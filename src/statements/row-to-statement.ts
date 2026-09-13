import type { SQLOutputValue } from 'node:sqlite';
import type { StatementRecord } from '../types/statement.interface';

export function rowToStatement(row: Record<string, SQLOutputValue>): StatementRecord {
  const { id, text, isActive, createdAt, updatedAt } = row;

  if (typeof id !== 'number' || typeof text !== 'string' || typeof createdAt !== 'string' || typeof updatedAt !== 'string') {
    throw new Error('De database heeft ongeldige stellinggegevens teruggegeven.');
  }

  return { id, text, isActive: isActive === 1, createdAt, updatedAt };
}
