import type { DatabaseSync } from 'node:sqlite';
import type { StatementRecord } from '../types/statement.interface';
import { rowToStatement } from './row-to-statement';

export function listStatements(database: DatabaseSync): StatementRecord[] {
  const rows = database.prepare(`
    SELECT id, text, is_active AS isActive, created_at AS createdAt, updated_at AS updatedAt
    FROM statements
    ORDER BY id
  `).all();

  return rows.map(rowToStatement);
}
