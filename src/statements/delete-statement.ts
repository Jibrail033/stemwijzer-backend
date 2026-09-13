import type { DatabaseSync } from 'node:sqlite';

export function deleteStatement(database: DatabaseSync, id: number): boolean {
  const result = database.prepare('DELETE FROM statements WHERE id = ?').run(id);

  return Number(result.changes) > 0;
}
