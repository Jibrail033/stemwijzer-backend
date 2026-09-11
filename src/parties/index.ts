import type { IncomingMessage, ServerResponse } from 'node:http';
import type { DatabaseSync } from 'node:sqlite';
import { readJsonBody } from '../http/read-json-body';
import { RequestError } from '../http/request-error';
import { createParty } from './create-party';
import { validateParty } from './validation';

const created = 201;
const internalServerError = 500;

export async function handleCreatePartyRequest(database: DatabaseSync, request: IncomingMessage, response: ServerResponse): Promise<void> {
  try {
    const body = await readJsonBody(request);
    const input = validateParty(body);
    const party = createParty(database, input);

    response.writeHead(created);
    response.end(JSON.stringify(party));
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

    console.error('Partij aanmaken mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De partij kon niet worden aangemaakt.' }));
  }
}
