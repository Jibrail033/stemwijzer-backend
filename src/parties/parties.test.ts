import { deepStrictEqual, strictEqual, ok } from 'node:assert';
import { once } from 'node:events';
import { it } from 'node:test';
import { openDatabase } from '../database';
import { createApp } from '../server';

const created = 201;
const badRequest = 400;
const methodNotAllowed = 405;
const payloadTooLarge = 413;
const unsupportedMediaType = 415;
const internalServerError = 500;
const maximumNameLength = 100;
const maximumUrlLength = 255;
const oversizedLength = 65537;

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

      const wrongMethod = await fetch(url);

      strictEqual(wrongMethod.status, methodNotAllowed);
      strictEqual(wrongMethod.headers.get('allow'), 'POST');
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
