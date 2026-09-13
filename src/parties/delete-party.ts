import type { DatabaseSync } from 'node:sqlite';

export function deleteParty(database: DatabaseSync, id: number): boolean {
  const result = database.prepare('DELETE FROM parties WHERE id = ?').run(id);

  return Number(result.changes) > 0;
}
