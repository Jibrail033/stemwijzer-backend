import type { IncomingMessage } from 'node:http';
import { RequestError } from './request-error';

const payloadTooLarge = 413;
const unsupportedMediaType = 415;
const maximumBodyBytes = 65536;

export async function readJsonBody(request: IncomingMessage): Promise<unknown> {
  if (request.headers['content-type']?.split(';')[0]?.trim().toLowerCase() !== 'application/json') {
    request.resume();

    throw new RequestError('Gebruik Content-Type: application/json.', unsupportedMediaType);
  }

  return new Promise((resolve, reject) => {
    const chunks: Buffer[] = [];
    let bytes = 0;

    function onData(chunk: Buffer): void {
      bytes += chunk.length;

      if (bytes > maximumBodyBytes) {
        chunks.length = 0;
        request.removeListener('data', onData);
        request.resume();
        reject(new RequestError('De aanvraag mag maximaal 64 KiB groot zijn.', payloadTooLarge));

        return;
      }

      chunks.push(chunk);
    }

    request.on('data', onData);
    request.once('error', reject);
    request.once('aborted', () => {
      reject(new RequestError('De aanvraag is afgebroken.'));
    });
    request.once('end', () => {
      if (bytes > maximumBodyBytes) {
        return;
      }

      try {
        resolve(JSON.parse(Buffer.concat(chunks).toString('utf8')) as unknown);
      }
      catch {
        reject(new RequestError('De aanvraag moet geldige JSON bevatten.'));
      }
    });
  });
}
