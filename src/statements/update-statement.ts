import type { DatabaseSync, SQLInputValue } from 'node:sqlite';
import type { UpdateStatementInput } from '../types/statement.interface';

export function updateStatement(database: DatabaseSync, id: number, input: UpdateStatementInput): boolean {
  const assignments: string[] = [];
  const values: SQLInputValue[] = [];

  if (input.text !== undefined) {
    assignments.push('text = ?');
    values.push(input.text);
  }

  if (input.isActive !== undefined) {
    assignments.push('is_active = ?');
    values.push(input.isActive ? 1 : 0);
  }

  const result = database.prepare(`UPDATE statements SET ${assignments.join(', ')} WHERE id = ?`).run(...values, id);

  return Number(result.changes) > 0;
}
