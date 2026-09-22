import type { IncomingMessage, ServerResponse } from 'node:http';
import type { DatabaseSync } from 'node:sqlite';
import type { LoginResult } from '../types/auth.interface';
import { readJsonBody } from '../http/read-json-body';
import { RequestError } from '../http/request-error';
import { createToken } from './create-token';
import { findSuperadminByEmail } from './find-superadmin-by-email';
import { verifyPassword } from './hash-password';
import { validateLogin } from './validation';

const ok = 200;
const unauthorized = 401;
const internalServerError = 500;
const invalidCredentialsMessage = 'Onjuiste combinatie van e-mailadres en wachtwoord.';

export async function handleLoginRequest(database: DatabaseSync, request: IncomingMessage, response: ServerResponse): Promise<void> {
  try {
    const body = await readJsonBody(request);
    const input = validateLogin(body);
    const superadmin = findSuperadminByEmail(database, input.email);

    if (!superadmin || !verifyPassword(input.password, superadmin.passwordHash)) {
      response.writeHead(unauthorized);
      response.end(JSON.stringify({ error: invalidCredentialsMessage }));

      return;
    }

    const result: LoginResult = {
      token: createToken(),
      user: { id: superadmin.id, name: superadmin.name, email: superadmin.email },
    };

    response.writeHead(ok);
    response.end(JSON.stringify(result));
  }
  catch (error: unknown) {
    if (response.destroyed) {
      return;
    }

    if (error instanceof RequestError) {
      response.writeHead(error.status);
      response.end(JSON.stringify({ error: error.message }));

      return;
    }

    console.error('Inloggen mislukt:', error);
    response.writeHead(internalServerError);
    response.end(JSON.stringify({ error: 'Inloggen is niet gelukt.' }));
  }
}
