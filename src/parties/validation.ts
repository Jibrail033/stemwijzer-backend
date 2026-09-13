import type { CreatePartyInput, UpdatePartyInput } from '../types/party.interface';
import { RequestError } from '../http/request-error';

const maximumNameLength = 100;
const maximumImageUrlLength = 255;

function validateName(value: unknown): string {
  if (typeof value !== 'string' || value.trim().length === 0 || Array.from(value.trim()).length > maximumNameLength || value.includes('\0')) {
    throw new RequestError('name is verplicht en mag maximaal 100 tekens bevatten, zonder nultekens.');
  }

  return value.trim();
}

function validateDescription(value: unknown): string | null {
  if (value !== null && (typeof value !== 'string' || value.includes('\0'))) {
    throw new RequestError('description moet tekst zonder nultekens of null zijn.');
  }

  return value;
}

function validateIsActive(value: unknown): boolean {
  if (typeof value !== 'boolean') {
    throw new RequestError('isActive moet true of false zijn.');
  }

  return value;
}

function validateImageUrl(value: unknown): string | null {
  if (value === null) {
    return null;
  }

  if (typeof value !== 'string' || value.trim().length === 0 || Array.from(value.trim()).length > maximumImageUrlLength || value.includes('\0')) {
    throw new RequestError('imageUrl moet een URL van maximaal 255 tekens of null zijn.');
  }

  try {
    const url = new URL(value);

    if (url.protocol !== 'http:' && url.protocol !== 'https:') {
      throw new RequestError('imageUrl moet een geldige HTTP- of HTTPS-URL zijn.');
    }
  }
  catch {
    throw new RequestError('imageUrl moet een geldige HTTP- of HTTPS-URL zijn.');
  }

  return value.trim();
}

function readBody(body: unknown, invalidMessage: string): Record<string, unknown> {
  if (typeof body !== 'object' || body === null || Array.isArray(body)) {
    throw new RequestError(invalidMessage);
  }

  const allowedFields = new Set(['name', 'description', 'imageUrl', 'isActive']);

  if (Object.keys(body).some(key => !allowedFields.has(key))) {
    throw new RequestError('Alleen name, description, imageUrl en isActive zijn toegestaan.');
  }

  return { ...body };
}

export function validateParty(body: unknown): CreatePartyInput {
  const fields = readBody(body, 'Stuur een JSON-object met de partijgegevens.');

  return {
    name: validateName('name' in fields ? fields['name'] : undefined),
    description: validateDescription('description' in fields ? fields['description'] : null),
    imageUrl: validateImageUrl('imageUrl' in fields ? fields['imageUrl'] : null),
    isActive: validateIsActive('isActive' in fields ? fields['isActive'] : true),
  };
}

export function validateUpdateParty(body: unknown): UpdatePartyInput {
  const fields = readBody(body, 'Stuur een JSON-object met de te wijzigen velden.');

  if (Object.keys(fields).length === 0) {
    throw new RequestError('Stuur ten minste één veld om te wijzigen.');
  }

  const result: { name?: string, description?: string | null, imageUrl?: string | null, isActive?: boolean } = {};

  if ('name' in fields) {
    result.name = validateName(fields['name']);
  }

  if ('description' in fields) {
    result.description = validateDescription(fields['description']);
  }

  if ('imageUrl' in fields) {
    result.imageUrl = validateImageUrl(fields['imageUrl']);
  }

  if ('isActive' in fields) {
    result.isActive = validateIsActive(fields['isActive']);
  }

  return result;
}
