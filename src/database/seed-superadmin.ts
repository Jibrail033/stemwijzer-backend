import { hashPassword } from '../auth/hash-password';
import { openDatabase } from './index';

const defaultEmail = 'superadmin@stemwijzer.nl';
const defaultPassword = 'superadmin123';
const defaultName = 'Super Admin';

const email = process.env['SUPERADMIN_EMAIL'] ?? defaultEmail;
const password = process.env['SUPERADMIN_PASSWORD'] ?? defaultPassword;
const name = process.env['SUPERADMIN_NAME'] ?? defaultName;

const database = openDatabase();

const existing = database.prepare('SELECT id FROM superadmins WHERE email = ?').get(email);

if (existing) {
  process.stdout.write(`Superadmin met e-mailadres ${email} bestaat al, overslaan.\n`);
}
else {
  database.prepare('INSERT INTO superadmins (name, email, password_hash) VALUES (?, ?, ?)').run(name, email, hashPassword(password));
  process.stdout.write(`Superadmin aangemaakt.\n  E-mailadres: ${email}\n  Wachtwoord:  ${password}\n`);
}

database.close();
