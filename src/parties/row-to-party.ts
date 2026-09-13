import type { SQLOutputValue } from 'node:sqlite';
import type { Party } from '../types/party.interface';

export function rowToParty(row: Record<string, SQLOutputValue>): Party {
  const { id, name, description, imageUrl, isActive, createdAt, updatedAt } = row;

  if (typeof id !== 'number' || typeof name !== 'string' || typeof createdAt !== 'string' || typeof updatedAt !== 'string') {
    throw new Error('De database heeft ongeldige partijgegevens teruggegeven.');
  }

  if (description !== null && typeof description !== 'string') {
    throw new Error('De database heeft ongeldige partijgegevens teruggegeven.');
  }

  if (imageUrl !== null && typeof imageUrl !== 'string') {
    throw new Error('De database heeft ongeldige partijgegevens teruggegeven.');
  }

  return { id, name, description, imageUrl, isActive: isActive === 1, createdAt, updatedAt };
}
