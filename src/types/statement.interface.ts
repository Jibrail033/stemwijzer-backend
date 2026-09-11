import type { SQLOutputValue } from 'node:sqlite';

export interface StatementResult {
  readonly index: number
  readonly id: SQLOutputValue
  readonly text: SQLOutputValue
  readonly partyAnswers: Record<string, SQLOutputValue>[]
}
