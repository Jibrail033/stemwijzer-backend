import { deepStrictEqual, strictEqual } from 'node:assert';
import { once } from 'node:events';
import { it } from 'node:test';
import { openDatabase } from '../database';
import { createApp } from '../server';

const ok = 200;
const badRequest = 400;
const notFound = 404;
const methodNotAllowed = 405;
const internalServerError = 500;

void it('serves statements and party answers over HTTP', async (context) => {
  const database = openDatabase(':memory:');
  const server = createApp(database);

  try {
    database.exec(`
      INSERT INTO superadmins (name, email, password_hash) VALUES ('Test', 'test@example.test', '!disabled');
      INSERT INTO statements (id, text, created_by, is_active) VALUES
        (10, 'Eerste stelling over CO₂', 1, 1),
        (20, 'Verborgen', 1, 0),
        (30, 'Laatste stelling', 1, 1);
      INSERT INTO parties (id, name, is_active) VALUES
        (1, 'Partij A', 1), (2, 'Partij B', 1), (3, 'Partij C', 1),
        (4, 'Nog geen antwoord', 1), (5, 'Inactieve partij', 0);
      INSERT INTO party_answers (party_id, statement_id, answer, updated_at) VALUES
        (1, 10, 'oneens', '2000-01-01 00:00:00'),
        (1, 10, 'neutraal', '2020-01-01 00:00:00'),
        (1, 10, 'eens', '2020-01-01 00:00:00'),
        (2, 10, 'neutraal', '2020-01-01 00:00:00'),
        (3, 10, 'oneens', '2020-01-01 00:00:00'),
        (5, 10, 'eens', '2020-01-01 00:00:00'),
        (1, 30, 'oneens', '2020-01-01 00:00:00');
    `);

    server.listen(0, '127.0.0.1');
    await once(server, 'listening');

    const address = server.address();

    if (!address || typeof address === 'string') {
      throw new Error('Expected a TCP address');
    }

    const baseUrl = `http://127.0.0.1:${String(address.port)}`;

    await context.test('returns one statement with the latest answer for each active party', async () => {
      const response = await fetch(`${baseUrl}/statements?index=0`);

      strictEqual(response.status, ok);
      strictEqual(response.headers.get('content-type'), 'application/json; charset=utf-8');
      deepStrictEqual(await response.json(), {
        index: 0,
        id: 10,
        text: 'Eerste stelling over CO₂',
        partyAnswers: [
          { partyId: 1, partyName: 'Partij A', answer: 'eens' },
          { partyId: 2, partyName: 'Partij B', answer: 'neutraal' },
          { partyId: 3, partyName: 'Partij C', answer: 'oneens' },
          { partyId: 4, partyName: 'Nog geen antwoord', answer: null },
        ],
      });
    });

    await context.test('uses the position among active statements, not the database ID', async () => {
      const response = await fetch(`${baseUrl}/statements?index=1`);

      strictEqual(response.status, ok);
      deepStrictEqual(await response.json(), {
        index: 1,
        id: 30,
        text: 'Laatste stelling',
        partyAnswers: [
          { partyId: 1, partyName: 'Partij A', answer: 'oneens' },
          { partyId: 2, partyName: 'Partij B', answer: null },
          { partyId: 3, partyName: 'Partij C', answer: null },
          { partyId: 4, partyName: 'Nog geen antwoord', answer: null },
        ],
      });
    });

    await context.test('rejects missing, duplicate and malformed indexes', async () => {
      for (const query of ['', '?index=', '?index=-1', '?index=1.5', '?index=abc', '?index=1e1', '?index=%20', '?index=0&index=1', '?index=9007199254740992', '?index=0%20OR%201=1']) {
        const response = await fetch(`${baseUrl}/statements${query}`);

        strictEqual(response.status, badRequest, query);
        await response.text();
      }
    });

    await context.test('returns 404 beyond the last statement or for an unknown route', async () => {
      for (const path of ['/statements?index=2', '/unknown']) {
        const response = await fetch(`${baseUrl}${path}`);

        strictEqual(response.status, notFound);
        await response.text();
      }
    });

    await context.test('only allows GET requests', async () => {
      const response = await fetch(`${baseUrl}/statements?index=0`, { method: 'POST' });

      strictEqual(response.status, methodNotAllowed);
      strictEqual(response.headers.get('allow'), 'GET');
      await response.text();
    });

    await context.test('returns an empty party list when no active parties exist', async () => {
      database.exec('UPDATE parties SET is_active = 0');

      const response = await fetch(`${baseUrl}/statements?index=0`);

      deepStrictEqual(await response.json(), { index: 0, id: 10, text: 'Eerste stelling over CO₂', partyAnswers: [] });
    });

    await context.test('returns 404 when no active statements exist', async () => {
      database.exec('UPDATE statements SET is_active = 0');

      const response = await fetch(`${baseUrl}/statements?index=0`);

      strictEqual(response.status, notFound);
      await response.text();
    });

    await context.test('hides database error details', async (errorContext) => {
      errorContext.mock.method(console, 'error', () => undefined);
      database.close();

      const response = await fetch(`${baseUrl}/statements?index=0`);

      strictEqual(response.status, internalServerError);
      deepStrictEqual(await response.json(), { error: 'De stelling kon niet worden opgehaald.' });
    });
  }
  finally {
    if (server.listening) {
      await new Promise<void>((resolve, reject) => {
        server.close((error) => {
          if (error) {
            reject(error);
          }
          else {
            resolve();
          }
        });
      });
    }

    if (database.isOpen) {
      database.close();
    }
  }
});
