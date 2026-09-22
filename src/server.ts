import type { Server } from 'node:http';
import type { DatabaseSync } from 'node:sqlite';
import { createServer } from 'node:http';
import { handleLoginRequest } from './auth';
import {
  handleStatementRequest,
  handleCreateStatementRequest,
  handleListStatementsRequest,
  handleGetStatementByIdRequest,
  handleUpdateStatementRequest,
  handleDeleteStatementRequest,
} from './statements';
import { handleMatchingRequest } from './matching';
import {
  handleCreatePartyRequest,
  handleListPartiesRequest,
  handleGetPartyByIdRequest,
  handleUpdatePartyRequest,
  handleDeletePartyRequest,
} from './parties';
import { parseId } from './http/parse-id';

const notFound = 404;
const methodNotAllowed = 405;
const badRequest = 400;
const internalServerError = 500;

const statementIdPattern = /^\/statements\/([^/]+)$/u;
const partyIdPattern = /^\/parties\/([^/]+)$/u;

export function createApp(database: DatabaseSync): Server {
  return createServer((request, response) => {
    response.setHeader('Content-Type', 'application/json; charset=utf-8');

    try {
      const url = new URL(request.url ?? '/', 'http://localhost');
      const method = request.method ?? '';

      if (url.pathname === '/auth/login') {
        if (method !== 'POST') {
          response.writeHead(methodNotAllowed, { allow: 'POST' });
          response.end(JSON.stringify({ error: 'Gebruik POST voor deze route.' }));

          return;
        }

        void handleLoginRequest(database, request, response);

        return;
      }

      if (url.pathname === '/matching') {
        if (method !== 'POST') {
          response.writeHead(methodNotAllowed, { allow: 'POST' });
          response.end(JSON.stringify({ error: 'Gebruik POST voor deze route.' }));

          return;
        }

        void handleMatchingRequest(database, request, response);

        return;
      }

      if (url.pathname === '/statements') {
        if (method === 'GET') {
          handleStatementRequest(database, url.searchParams, response);

          return;
        }

        if (method === 'POST') {
          void handleCreateStatementRequest(database, request, response);

          return;
        }

        response.writeHead(methodNotAllowed, { allow: 'GET, POST' });
        response.end(JSON.stringify({ error: 'Gebruik GET of POST voor deze route.' }));

        return;
      }

      if (url.pathname === '/statements/all') {
        if (method !== 'GET') {
          response.writeHead(methodNotAllowed, { allow: 'GET' });
          response.end(JSON.stringify({ error: 'Gebruik GET voor deze route.' }));

          return;
        }

        handleListStatementsRequest(database, response);

        return;
      }

      const statementIdMatch = statementIdPattern.exec(url.pathname);

      if (statementIdMatch) {
        const id = parseId(statementIdMatch[1]);

        if (id === undefined) {
          response.writeHead(badRequest);
          response.end(JSON.stringify({ error: 'Het id in de URL moet een positief geheel getal zijn.' }));

          return;
        }

        if (method === 'GET') {
          handleGetStatementByIdRequest(database, id, response);

          return;
        }

        if (method === 'PATCH') {
          void handleUpdateStatementRequest(database, id, request, response);

          return;
        }

        if (method === 'DELETE') {
          handleDeleteStatementRequest(database, id, response);

          return;
        }

        response.writeHead(methodNotAllowed, { allow: 'GET, PATCH, DELETE' });
        response.end(JSON.stringify({ error: 'Gebruik GET, PATCH of DELETE voor deze route.' }));

        return;
      }

      if (url.pathname === '/parties') {
        if (method === 'GET') {
          handleListPartiesRequest(database, response);

          return;
        }

        if (method === 'POST') {
          void handleCreatePartyRequest(database, request, response);

          return;
        }

        response.writeHead(methodNotAllowed, { allow: 'GET, POST' });
        response.end(JSON.stringify({ error: 'Gebruik GET of POST voor deze route.' }));

        return;
      }

      const partyIdMatch = partyIdPattern.exec(url.pathname);

      if (partyIdMatch) {
        const id = parseId(partyIdMatch[1]);

        if (id === undefined) {
          response.writeHead(badRequest);
          response.end(JSON.stringify({ error: 'Het id in de URL moet een positief geheel getal zijn.' }));

          return;
        }

        if (method === 'GET') {
          handleGetPartyByIdRequest(database, id, response);

          return;
        }

        if (method === 'PATCH') {
          void handleUpdatePartyRequest(database, id, request, response);

          return;
        }

        if (method === 'DELETE') {
          handleDeletePartyRequest(database, id, response);

          return;
        }

        response.writeHead(methodNotAllowed, { allow: 'GET, PATCH, DELETE' });
        response.end(JSON.stringify({ error: 'Gebruik GET, PATCH of DELETE voor deze route.' }));

        return;
      }

      response.writeHead(notFound);
      response.end(JSON.stringify({ error: 'Route niet gevonden.' }));
    }
    catch (error: unknown) {
      console.error('Aanvraag verwerken mislukt:', error);
      response.writeHead(internalServerError);
      response.end(JSON.stringify({ error: 'De aanvraag kon niet worden verwerkt.' }));
    }
  });
}
