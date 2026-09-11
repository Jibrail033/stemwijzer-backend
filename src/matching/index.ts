import type { IncomingMessage, ServerResponse } from 'node:http';
import type { DatabaseSync } from 'node:sqlite';
import { matchResults } from './match-results';
import { validateAnswers } from './validation';
import { readJsonBody } from '../http/read-json-body';
import { RequestError } from '../http/request-error';

const ok = 200;
const internalServerError = 500;

export async function handleMatchingRequest(database: DatabaseSync, request: IncomingMessage, response: ServerResponse): Promise<void> {
  try {
    const body = await readJsonBody(request);
    const answers = validateAnswers(database, body);
    const results = matchResults(database, answers);

    response.writeHead(ok);
    response.end(JSON.stringify(results));
  }
  catch (error: unknown) {
    if (response.destroyed) {
      return;
    }

    if (error instanceof RequestError) {
      response.writeHead(error.status);
      response.end(JSON.stringify({ error: error.message }));

      return;
    }

    console.error('Matching mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De overeenkomst met partijen kon niet worden berekend.' }));
  }
}
