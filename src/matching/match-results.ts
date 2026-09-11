import type { DatabaseSync } from 'node:sqlite';
import type { Answer } from '../types/answer.interface';
import type { MatchingResult, PartyMatch } from '../types/matching.interface';

const percentageScale = 100;
const roundingScale = 100;

export function matchResults(database: DatabaseSync, answers: ReadonlyMap<number, Answer>): MatchingResult {
  const parties = database.prepare('SELECT id, name FROM parties WHERE is_active = 1 ORDER BY id').all();

  const partyAnswers = database.prepare(/* sql */ `
    SELECT current.statement_id AS statementId, current.answer
    FROM party_answers AS current
    JOIN statements ON statements.id = current.statement_id AND statements.is_active = 1
    WHERE current.party_id = ? AND current.id = (
      SELECT id FROM party_answers
      WHERE party_id = current.party_id AND statement_id = current.statement_id
      ORDER BY updated_at DESC, id DESC
      LIMIT 1
    )
  `);

  const matches = parties.map((party): PartyMatch => {
    const partyId = party['id'];
    const partyName = party['name'];

    if (typeof partyId !== 'number' || typeof partyName !== 'string') {
      throw new Error('Ongeldige partijgegevens in de database.');
    }

    let matchedAnswers = 0;
    let comparedAnswers = 0;

    for (const row of partyAnswers.all(partyId)) {
      const { statementId } = row;
      const userAnswer = typeof statementId === 'number' ? answers.get(statementId) : undefined;

      if (userAnswer !== undefined) {
        comparedAnswers += 1;

        if (userAnswer === row['answer']) {
          matchedAnswers += 1;
        }
      }
    }

    return {
      partyId,
      partyName,
      matchPercentage: comparedAnswers === 0 ? null : Math.round(matchedAnswers / comparedAnswers * percentageScale * roundingScale) / roundingScale,
      matchedAnswers,
      comparedAnswers,
      missingAnswers: answers.size - comparedAnswers,
    };
  });

  matches.sort((left, right) => (right.matchPercentage ?? -1) - (left.matchPercentage ?? -1)
    || right.comparedAnswers - left.comparedAnswers
    || left.partyId - right.partyId);

  return { totalAnswers: answers.size, matches };
}
