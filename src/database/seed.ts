import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { openDatabase } from './index';

const projectRoot = resolve(__dirname, '../..');
const seedFiles = ['seed-statements.sql', 'seed-parties.sql', 'seed-party-answers.sql'];

const database = openDatabase();

for (const fileName of seedFiles) {
  database.exec(readFileSync(resolve(projectRoot, 'database', fileName), 'utf8'));
}

database.close();
