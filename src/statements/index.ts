import type { IncomingMessage, ServerResponse } from 'node:http';
import type { DatabaseSync } from 'node:sqlite';
import { readJsonBody } from '../http/read-json-body';
import { RequestError } from '../http/request-error';
import { getStatement } from './get-statement';
import { createStatement } from './create-statement';
import { listStatements } from './list-statements';
import { getStatementById } from './get-statement-by-id';
import { updateStatement } from './update-statement';
import { deleteStatement } from './delete-statement';
import { validateCreateStatement, validateUpdateStatement } from './validation';

const ok = 200;
const created = 201;
const noContent = 204;
const badRequest = 400;
const notFound = 404;
const conflict = 409;
const internalServerError = 500;

function isForeignKeyViolation(error: unknown): boolean {
  return error instanceof Error && 'code' in error && error.code === 'ERR_SQLITE_ERROR' && error.message.includes('FOREIGN KEY constraint failed');
}

function writeStatementNotFound(response: ServerResponse): void {
  response.writeHead(notFound);
  response.end(JSON.stringify({ error: 'Geen stelling gevonden met dit id.' }));
}

export function handleStatementRequest(database: DatabaseSync, query: URLSearchParams, response: ServerResponse): void {
  const values = query.getAll('index');
  const rawIndex = values[0] ?? '';
  const index = Number(rawIndex);

  if (values.length !== 1 || !/^(?:0|[1-9]\d*)$/u.test(rawIndex) || !Number.isSafeInteger(index)) {
    response.writeHead(badRequest);
    response.end(JSON.stringify({ error: 'index moet een geheel getal vanaf 0 zijn.' }));

    return;
  }

  try {
    const statement = getStatement(database, index);

    if (!statement) {
      response.writeHead(notFound);
      response.end(JSON.stringify({ error: 'Geen actieve stelling gevonden voor deze index.' }));

      return;
    }

    response.writeHead(ok);
    response.end(JSON.stringify(statement));
  }
  catch (error: unknown) {
    console.error('Stelling ophalen mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De stelling kon niet worden opgehaald.' }));
  }
}

export async function handleCreateStatementRequest(database: DatabaseSync, request: IncomingMessage, response: ServerResponse): Promise<void> {
  try {
    const body = await readJsonBody(request);
    const input = validateCreateStatement(body);
    const statement = createStatement(database, input);

    response.writeHead(created);
    response.end(JSON.stringify(statement));
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

    console.error('Stelling aanmaken mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De stelling kon niet worden aangemaakt.' }));
  }
}

export function handleListStatementsRequest(database: DatabaseSync, response: ServerResponse): void {
  try {
    const statements = listStatements(database);

    response.writeHead(ok);
    response.end(JSON.stringify(statements));
  }
  catch (error: unknown) {
    console.error('Stellingen ophalen mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De stellingen konden niet worden opgehaald.' }));
  }
}

export function handleGetStatementByIdRequest(database: DatabaseSync, id: number, response: ServerResponse): void {
  try {
    const statement = getStatementById(database, id);

    if (!statement) {
      writeStatementNotFound(response);

      return;
    }

    response.writeHead(ok);
    response.end(JSON.stringify(statement));
  }
  catch (error: unknown) {
    console.error('Stelling ophalen mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De stelling kon niet worden opgehaald.' }));
  }
}

export async function handleUpdateStatementRequest(database: DatabaseSync, id: number, request: IncomingMessage, response: ServerResponse): Promise<void> {
  try {
    const body = await readJsonBody(request);
    const input = validateUpdateStatement(body);
    const updated = updateStatement(database, id, input);

    if (!updated) {
      writeStatementNotFound(response);

      return;
    }

    response.writeHead(ok);
    response.end(JSON.stringify(getStatementById(database, id)));
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

    console.error('Stelling wijzigen mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De stelling kon niet worden gewijzigd.' }));
  }
}

export function handleDeleteStatementRequest(database: DatabaseSync, id: number, response: ServerResponse): void {
  try {
    const deleted = deleteStatement(database, id);

    if (!deleted) {
      writeStatementNotFound(response);

      return;
    }

    response.writeHead(noContent);
    response.end();
  }
  catch (error: unknown) {
    if (isForeignKeyViolation(error)) {
      response.writeHead(conflict);
      response.end(JSON.stringify({ error: 'Deze stelling heeft nog partijantwoorden en kan niet worden verwijderd.' }));

      return;
    }

    console.error('Stelling verwijderen mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'De stelling kon niet worden verwijderd.' }));
  }
}
