import { randomBytes } from 'node:crypto';

const tokenBytes = 32;

export function createToken(): string {
  return randomBytes(tokenBytes).toString('hex');
}
