import type { Server } from 'node:http';
import type { DatabaseSync } from 'node:sqlite';
import { createServer } from 'node:http';
import { handleStatementRequest } from './statements';
import { handleMatchingRequest } from './matching';
import { handleCreatePartyRequest } from './parties';

const notFound = 404;
const methodNotAllowed = 405;
const internalServerError = 500;

export function createApp(database: DatabaseSync): Server {
  return createServer((request, response) => {
    response.setHeader('Content-Type', 'application/json; charset=utf-8');

    try {
      const url = new URL(request.url ?? '/', 'http://localhost');

      if (url.pathname === '/parties') {
        if (request.method !== 'POST') {
          response.writeHead(methodNotAllowed, { allow: 'POST' });
          response.end(JSON.stringify({ error: 'Gebruik POST voor deze route.' }));

          return;
        }

        void handleCreatePartyRequest(database, request, response);

        return;
      }

      if (url.pathname === '/matching') {
        if (request.method !== 'POST') {
          response.writeHead(methodNotAllowed, { allow: 'POST' });
          response.end(JSON.stringify({ error: 'Gebruik POST voor deze route.' }));

          return;
        }

        void handleMatchingRequest(database, request, response);

        return;
      }

      if (url.pathname !== '/statements') {
        response.writeHead(notFound);
        response.end(JSON.stringify({ error: 'Route niet gevonden.' }));

        return;
      }

      if (request.method !== 'GET') {
        response.writeHead(methodNotAllowed, { allow: 'GET' });
        response.end(JSON.stringify({ error: 'Gebruik GET voor deze route.' }));

        return;
      }

      handleStatementRequest(database, url.searchParams, response);
    }
    catch (error: unknown) {
      console.error('Stelling ophalen mislukt:', error);
      response.writeHead(internalServerError);
      response.end(JSON.stringify({ error: 'De stelling kon niet worden opgehaald.' }));
    }
  });
}
