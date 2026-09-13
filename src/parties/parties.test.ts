import { deepStrictEqual, strictEqual, ok } from 'node:assert';
import { once } from 'node:events';
import { it } from 'node:test';
import { openDatabase } from '../database';
import { createApp } from '../server';

const success = 200;
const created = 201;
const noContent = 204;
const badRequest = 400;
const notFound = 404;
const methodNotAllowed = 405;
const conflict = 409;
const payloadTooLarge = 413;
const unsupportedMediaType = 415;
const internalServerError = 500;
const maximumNameLength = 100;
const maximumUrlLength = 255;
const oversizedLength = 65537;
const nonExistentId = 999;

void it('creates parties over HTTP', async (context) => {
  const database = openDatabase(':memory:');
  const server = createApp(database);

  try {
    server.listen(0, '127.0.0.1');
    await once(server, 'listening');

    const address = server.address();

    if (!address || typeof address === 'string') {
      throw new Error('Expected TCP address');
    }

    const url = `http://127.0.0.1:${String(address.port)}/parties`;

    async function post(body: unknown): Promise<Response> {
      return fetch(url, { method: 'POST', headers: [['content-type', 'application/json']], body: JSON.stringify(body) });
    }

    await context.test('creates a named party with defaults and timestamps', async () => {
      const response = await post({ name: '  Nieuwe partij  ' });
      const row = database.prepare('SELECT * FROM parties WHERE id = 1').get();

      strictEqual(response.status, created);
      strictEqual(response.headers.get('content-type'), 'application/json; charset=utf-8');
      ok(row);
      strictEqual(typeof row['created_at'], 'string');
      strictEqual(row['is_active'], 1);
      deepStrictEqual(await response.json(), {
        id: 1, name: 'Nieuwe partij', description: null, imageUrl: null, isActive: true,
        createdAt: row['created_at'], updatedAt: row['updated_at'],
      });
    });

    await context.test('stores optional fields and false without executing SQL in text', async () => {
      const input = { name: 'Partij O\'Brien', description: '\'); DROP TABLE parties; --', imageUrl: 'https://example.test/logo.png', isActive: false };
      const response = await post(input);
      const row = database.prepare('SELECT * FROM parties WHERE name = ?').get(input.name);

      strictEqual(response.status, created);
      ok(row);
      strictEqual(row['description'], input.description);
      strictEqual(row['image_url'], input.imageUrl);
      strictEqual(row['is_active'], 0);
      deepStrictEqual(await response.json(), { id: row['id'], ...input, createdAt: row['created_at'], updatedAt: row['updated_at'] });
    });

    await context.test('allows explicit nulls and schema length boundaries including Unicode', async () => {
      const imageUrl = 'https://example.test/'.padEnd(maximumUrlLength, 'a');

      for (const input of [
        { name: 'Nulls', description: null, imageUrl: null },
        { name: 'a'.repeat(maximumNameLength), imageUrl },
        { name: '🌍'.repeat(maximumNameLength) },
      ]) {
        const response = await post(input);

        strictEqual(response.status, created);
        await response.text();
      }
    });

    await context.test('rejects invalid fields without inserting rows', async () => {
      const before = database.prepare('SELECT COUNT(*) AS count FROM parties').get();

      const invalidBodies: unknown[] = [
        null, [], 'party', {}, { name: null }, { name: 1 }, { name: '  ' },
        { name: 'a'.repeat(maximumNameLength + 1) }, { name: 'x\0y' },
        { name: 'Valid', description: 1 }, { name: 'Valid', description: 'x\0y' },
        { name: 'Valid', isActive: 1 }, { name: 'Valid', isActive: 'false' }, { name: 'Valid', isActive: null },
        { name: 'Valid', imageUrl: 1 }, { name: 'Valid', imageUrl: '' }, { name: 'Valid', imageUrl: 'not a URL' },
        { name: 'Valid', imageUrl: 'javascript:alert(1)' }, { name: 'Valid', imageUrl: 'ftp://example.test/logo' },
        { name: 'Valid', imageUrl: 'https://example.test/'.padEnd(maximumUrlLength + 1, 'a') },
        { name: 'Valid', id: 123 }, { name: 'Valid', answers: [] },
      ];

      for (const input of invalidBodies) {
        const response = await post(input);

        strictEqual(response.status, badRequest, JSON.stringify(input));
        await response.text();
      }

      deepStrictEqual(database.prepare('SELECT COUNT(*) AS count FROM parties').get(), before);
    });

    await context.test('rejects invalid JSON, oversized requests, wrong media types and methods', async () => {
      const before = database.prepare('SELECT COUNT(*) AS count FROM parties').get();

      for (const body of ['', '{']) {
        const response = await fetch(url, { method: 'POST', headers: [['content-type', 'application/json']], body });

        strictEqual(response.status, badRequest);
        await response.text();
      }

      const wrongType = await fetch(url, { method: 'POST', body: '{}' });

      strictEqual(wrongType.status, unsupportedMediaType);
      await wrongType.text();

      const tooLarge = await fetch(url, { method: 'POST', headers: [['content-type', 'application/json']], body: ' '.repeat(oversizedLength) });

      strictEqual(tooLarge.status, payloadTooLarge);
      await tooLarge.text();

      const wrongMethod = await fetch(url, { method: 'PUT' });

      strictEqual(wrongMethod.status, methodNotAllowed);
      strictEqual(wrongMethod.headers.get('allow'), 'GET, POST');
      await wrongMethod.text();
      deepStrictEqual(database.prepare('SELECT COUNT(*) AS count FROM parties').get(), before);
    });

    await context.test('hides database errors', async (errorContext) => {
      errorContext.mock.method(console, 'error', () => undefined);
      database.close();

      const response = await post({ name: 'Valid' });

      strictEqual(response.status, internalServerError);
      deepStrictEqual(await response.json(), { error: 'De partij kon niet worden aangemaakt.' });
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

void it('lists, reads, updates and deletes parties over HTTP', async (context) => {
  const database = openDatabase(':memory:');
  const server = createApp(database);

  try {
    server.listen(0, '127.0.0.1');
    await once(server, 'listening');

    const address = server.address();

    if (!address || typeof address === 'string') {
      throw new Error('Expected TCP address');
    }

    const baseUrl = `http://127.0.0.1:${String(address.port)}/parties`;

    async function patch(id: number, body: unknown): Promise<Response> {
      return fetch(`${baseUrl}/${String(id)}`, { method: 'PATCH', headers: [['content-type', 'application/json']], body: JSON.stringify(body) });
    }

    await context.test('returns an empty list when there are no parties', async () => {
      const response = await fetch(baseUrl);

      strictEqual(response.status, success);
      deepStrictEqual(await response.json(), []);
    });

    database.exec(`
      INSERT INTO parties (id, name, description, image_url, is_active) VALUES
        (1, 'Partij A', 'Beschrijving A', 'https://example.test/a.png', 1),
        (2, 'Partij B', NULL, NULL, 0);
    `);

    await context.test('lists all parties, including inactive ones, ordered by id', async () => {
      const response = await fetch(baseUrl);
      const rows = database.prepare('SELECT * FROM parties ORDER BY id').all();

      strictEqual(response.status, success);
      deepStrictEqual(await response.json(), [
        { id: 1, name: 'Partij A', description: 'Beschrijving A', imageUrl: 'https://example.test/a.png', isActive: true, createdAt: rows[0]['created_at'], updatedAt: rows[0]['updated_at'] },
        { id: 2, name: 'Partij B', description: null, imageUrl: null, isActive: false, createdAt: rows[1]['created_at'], updatedAt: rows[1]['updated_at'] },
      ]);
    });

    await context.test('reads a single party by id, or 404 when missing', async () => {
      const found = await fetch(`${baseUrl}/1`);
      const body: unknown = await found.json();

      strictEqual(found.status, success);
      ok(typeof body === 'object' && body !== null && 'name' in body);
      strictEqual(body.name, 'Partij A');

      const missing = await fetch(`${baseUrl}/${String(nonExistentId)}`);

      strictEqual(missing.status, notFound);
      await missing.text();
    });

    await context.test('rejects an invalid id in the URL', async () => {
      const response = await fetch(`${baseUrl}/not-a-number`);

      strictEqual(response.status, badRequest);
      await response.text();
    });

    await context.test('updates one or more fields and refreshes updatedAt', async () => {
      database.exec('UPDATE parties SET updated_at = \'2000-01-01 00:00:00\' WHERE id = 1');

      const before = database.prepare('SELECT updated_at FROM parties WHERE id = 1').get();

      ok(before);

      const response = await patch(1, { isActive: false });
      const after = database.prepare('SELECT * FROM parties WHERE id = 1').get();

      ok(after);
      strictEqual(response.status, success);
      deepStrictEqual(await response.json(), {
        id: 1, name: 'Partij A', description: 'Beschrijving A', imageUrl: 'https://example.test/a.png',
        isActive: false, createdAt: after['created_at'], updatedAt: after['updated_at'],
      });
      strictEqual(after['is_active'], 0);
      ok(after['updated_at'] !== before['updated_at']);
    });

    await context.test('rejects invalid or empty update bodies without changing data', async () => {
      const before = database.prepare('SELECT * FROM parties WHERE id = 1').get();

      for (const body of [{}, { name: '' }, { isActive: 'no' }, { id: 5 }, { unknown: 'field' }]) {
        const response = await patch(1, body);

        strictEqual(response.status, badRequest, JSON.stringify(body));
        await response.text();
      }

      deepStrictEqual(database.prepare('SELECT * FROM parties WHERE id = 1').get(), before);
    });

    await context.test('returns 404 when updating a party that does not exist', async () => {
      const response = await patch(nonExistentId, { name: 'Nieuw' });

      strictEqual(response.status, notFound);
      await response.text();
    });

    await context.test('only allows GET, PATCH and DELETE on a party by id', async () => {
      const response = await fetch(`${baseUrl}/1`, { method: 'POST' });

      strictEqual(response.status, methodNotAllowed);
      strictEqual(response.headers.get('allow'), 'GET, PATCH, DELETE');
      await response.text();
    });

    await context.test('blocks deletion while party answers reference the party', async () => {
      database.exec(`
        INSERT INTO superadmins (id, name, email, password_hash) VALUES (1, 'Test', 'test@example.test', '!disabled');
        INSERT INTO statements (id, text, created_by) VALUES (1, 'Een stelling', 1);
        INSERT INTO party_answers (party_id, statement_id, answer) VALUES (2, 1, 'eens');
      `);

      const response = await fetch(`${baseUrl}/2`, { method: 'DELETE' });

      strictEqual(response.status, conflict);
      await response.text();
      ok(database.prepare('SELECT 1 FROM parties WHERE id = 2').get());
    });

    await context.test('deletes a party without references and returns 404 afterwards', async () => {
      const response = await fetch(`${baseUrl}/1`, { method: 'DELETE' });

      strictEqual(response.status, noContent);

      const gone = await fetch(`${baseUrl}/1`);

      strictEqual(gone.status, notFound);
      await gone.text();

      const secondDelete = await fetch(`${baseUrl}/1`, { method: 'DELETE' });

      strictEqual(secondDelete.status, notFound);
      await secondDelete.text();
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
