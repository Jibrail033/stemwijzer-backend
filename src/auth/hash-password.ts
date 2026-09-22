import { randomBytes, scryptSync, timingSafeEqual } from 'node:crypto';

const saltBytes = 16;
const keyLength = 64;
const hashPartCount = 2;

export function hashPassword(password: string): string {
  const salt = randomBytes(saltBytes).toString('hex');
  const derivedKey = scryptSync(password, salt, keyLength);

  return `${salt}:${derivedKey.toString('hex')}`;
}

export function verifyPassword(password: string, storedHash: string): boolean {
  const parts = storedHash.split(':');

  if (parts.length !== hashPartCount) {
    return false;
  }

  const [salt, hash] = parts;
  const expected = Buffer.from(hash, 'hex');
  const candidate = scryptSync(password, salt, keyLength);

  if (expected.length !== candidate.length) {
    return false;
  }

  return timingSafeEqual(expected, candidate);
}
