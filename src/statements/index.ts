import type { ServerResponse } from 'node:http';
import type { DatabaseSync } from 'node:sqlite';
import { getStatement } from './get-statement';

const ok = 200;
const badRequest = 400;
const notFound = 404;

export function handleStatementRequest(database: DatabaseSync, query: URLSearchParams, response: ServerResponse): void {
  const values = query.getAll('index');
  const rawIndex = values[0] ?? '';
  const index = Number(rawIndex);

  if (values.length !== 1 || !/^(?:0|[1-9]\d*)$/u.test(rawIndex) || !Number.isSafeInteger(index)) {
    response.writeHead(badRequest);
    response.end(JSON.stringify({ error: 'index moet een geheel getal vanaf 0 zijn.' }));

    return;
  }

  const statement = getStatement(database, index);

  if (!statement) {
    response.writeHead(notFound);
    response.end(JSON.stringify({ error: 'Geen actieve stelling gevonden voor deze index.' }));

    return;
  }

  response.writeHead(ok);
  response.end(JSON.stringify(statement));
}
