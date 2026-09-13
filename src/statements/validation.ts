import type { CreateStatementInput, UpdateStatementInput } from '../types/statement.interface';
import { RequestError } from '../http/request-error';

function validateText(value: unknown): string {
  if (typeof value !== 'string' || value.trim().length === 0 || value.includes('\0')) {
    throw new RequestError('text is verplicht en mag geen nultekens bevatten.');
  }

  return value.trim();
}

function validateIsActive(value: unknown): boolean {
  if (typeof value !== 'boolean') {
    throw new RequestError('isActive moet true of false zijn.');
  }

  return value;
}

function readBody(body: unknown, invalidMessage: string): Record<string, unknown> {
  if (typeof body !== 'object' || body === null || Array.isArray(body)) {
    throw new RequestError(invalidMessage);
  }

  const allowedFields = new Set(['text', 'isActive']);

  if (Object.keys(body).some(key => !allowedFields.has(key))) {
    throw new RequestError('Alleen text en isActive zijn toegestaan.');
  }

  return { ...body };
}

export function validateCreateStatement(body: unknown): CreateStatementInput {
  const fields = readBody(body, 'Stuur een JSON-object met de stellinggegevens.');

  return {
    text: validateText('text' in fields ? fields['text'] : undefined),
    isActive: validateIsActive('isActive' in fields ? fields['isActive'] : true),
  };
}

export function validateUpdateStatement(body: unknown): UpdateStatementInput {
  const fields = readBody(body, 'Stuur een JSON-object met de te wijzigen velden.');

  if (Object.keys(fields).length === 0) {
    throw new RequestError('Stuur ten minste één veld om te wijzigen.');
  }

  const result: { text?: string, isActive?: boolean } = {};

  if ('text' in fields) {
    result.text = validateText(fields['text']);
  }

  if ('isActive' in fields) {
    result.isActive = validateIsActive(fields['isActive']);
  }

  return result;
}
