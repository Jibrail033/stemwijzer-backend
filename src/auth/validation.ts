import type { LoginInput } from '../types/auth.interface';
import { RequestError } from '../http/request-error';

const maximumEmailLength = 100;

function validateEmail(value: unknown): string {
  if (typeof value !== 'string' || value.trim().length === 0 || Array.from(value.trim()).length > maximumEmailLength) {
    throw new RequestError('email is verplicht en mag maximaal 100 tekens bevatten.');
  }

  return value.trim().toLowerCase();
}

function validatePassword(value: unknown): string {
  if (typeof value !== 'string' || value.length === 0) {
    throw new RequestError('password is verplicht.');
  }

  return value;
}

function readBody(body: unknown): Record<string, unknown> {
  if (typeof body !== 'object' || body === null || Array.isArray(body)) {
    throw new RequestError('Stuur een JSON-object met email en password.');
  }

  const allowedFields = new Set(['email', 'password']);

  if (Object.keys(body).some(key => !allowedFields.has(key))) {
    throw new RequestError('Alleen email en password zijn toegestaan.');
  }

  return { ...body };
}

export function validateLogin(body: unknown): LoginInput {
  const fields = readBody(body);

  return {
    email: validateEmail('email' in fields ? fields['email'] : undefined),
    password: validatePassword('password' in fields ? fields['password'] : undefined),
  };
}
