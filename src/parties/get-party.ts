import type { DatabaseSync } from 'node:sqlite';
import type { Party } from '../types/party.interface';
import { rowToParty } from './row-to-party';

export function getPartyById(database: DatabaseSync, id: number): Party | undefined {
  const row = database.prepare(`
    SELECT id, name, description, image_url AS imageUrl, is_active AS isActive,
           created_at AS createdAt, updated_at AS updatedAt
    FROM parties
    WHERE id = ?
  `).get(id);

  return row ? rowToParty(row) : undefined;
}
