import type { CreatePartyInput } from '../types/party.interface';
import { RequestError } from '../http/request-error';

const maximumNameLength = 100;
const maximumImageUrlLength = 255;

export function validateParty(body: unknown): CreatePartyInput {
  if (typeof body !== 'object' || body === null || Array.isArray(body)) {
    throw new RequestError('Stuur een JSON-object met de partijgegevens.');
  }

  const allowedFields = new Set(['name', 'description', 'imageUrl', 'isActive']);

  if (Object.keys(body).some(key => !allowedFields.has(key))) {
    throw new RequestError('Alleen name, description, imageUrl en isActive zijn toegestaan.');
  }

  const name: unknown = 'name' in body ? body.name : undefined;
  const description: unknown = 'description' in body ? body.description : null;
  const imageUrl: unknown = 'imageUrl' in body ? body.imageUrl : null;
  const isActive: unknown = 'isActive' in body ? body.isActive : true;

  if (typeof name !== 'string' || name.trim().length === 0 || Array.from(name.trim()).length > maximumNameLength || name.includes('\0')) {
    throw new RequestError('name is verplicht en mag maximaal 100 tekens bevatten, zonder nultekens.');
  }

  if (description !== null && (typeof description !== 'string' || description.includes('\0'))) {
    throw new RequestError('description moet tekst zonder nultekens of null zijn.');
  }

  if (typeof isActive !== 'boolean') {
    throw new RequestError('isActive moet true of false zijn.');
  }

  if (imageUrl !== null) {
    if (typeof imageUrl !== 'string' || imageUrl.trim().length === 0 || Array.from(imageUrl.trim()).length > maximumImageUrlLength || imageUrl.includes('\0')) {
      throw new RequestError('imageUrl moet een URL van maximaal 255 tekens of null zijn.');
    }

    try {
      const url = new URL(imageUrl);

      if (url.protocol !== 'http:' && url.protocol !== 'https:') {
        throw new RequestError('imageUrl moet een geldige HTTP- of HTTPS-URL zijn.');
      }
    }
    catch {
      throw new RequestError('imageUrl moet een geldige HTTP- of HTTPS-URL zijn.');
    }
  }

  return { name: name.trim(), description, imageUrl: imageUrl === null ? null : imageUrl.trim(), isActive };
}
