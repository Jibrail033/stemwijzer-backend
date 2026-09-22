import type { DatabaseSync } from 'node:sqlite';

export interface SuperadminRecord {
  readonly id: number
  readonly name: string
  readonly email: string
  readonly passwordHash: string
}

export function findSuperadminByEmail(database: DatabaseSync, email: string): SuperadminRecord | undefined {
  const row = database.prepare(`
    SELECT id, name, email, password_hash AS passwordHash
    FROM superadmins
    WHERE email = ?
  `).get(email);

  if (!row) {
    return undefined;
  }

  const { id, name, email: rowEmail, passwordHash } = row;

  if (typeof id !== 'number' || typeof name !== 'string' || typeof rowEmail !== 'string' || typeof passwordHash !== 'string') {
    throw new Error('De database heeft ongeldige beheerdergegevens teruggegeven.');
  }

  return { id, name, email: rowEmail, passwordHash };
}
