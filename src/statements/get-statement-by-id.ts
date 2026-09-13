import type { DatabaseSync } from 'node:sqlite';
import type { StatementRecord } from '../types/statement.interface';
import { rowToStatement } from './row-to-statement';

export function getStatementById(database: DatabaseSync, id: number): StatementRecord | undefined {
  const row = database.prepare(`
    SELECT id, text, is_active AS isActive, created_at AS createdAt, updated_at AS updatedAt
    FROM statements
    WHERE id = ?
  `).get(id);

  return row ? rowToStatement(row) : undefined;
}
