import type { DatabaseSync, SQLInputValue } from 'node:sqlite';
import type { UpdatePartyInput } from '../types/party.interface';

export function updateParty(database: DatabaseSync, id: number, input: UpdatePartyInput): boolean {
  const assignments: string[] = [];
  const values: SQLInputValue[] = [];

  if (input.name !== undefined) {
    assignments.push('name = ?');
    values.push(input.name);
  }

  if (input.description !== undefined) {
    assignments.push('description = ?');
    values.push(input.description);
  }

  if (input.imageUrl !== undefined) {
    assignments.push('image_url = ?');
    values.push(input.imageUrl);
  }

  if (input.isActive !== undefined) {
    assignments.push('is_active = ?');
    values.push(input.isActive ? 1 : 0);
  }

  const result = database.prepare(`UPDATE parties SET ${assignments.join(', ')} WHERE id = ?`).run(...values, id);

  return Number(result.changes) > 0;
}
