-- Door de gebruiker aangeleverde stellingen; herhaalbaar zonder dubbele teksten.
-- Het technische importrecord heeft geen bruikbaar wachtwoord.
PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

INSERT INTO superadmins (name, email, password_hash)
SELECT 'Stellingenimport', 'statements-import@stemwijzer.invalid', '!disabled:statement-import'
WHERE NOT EXISTS (SELECT 1 FROM superadmins WHERE email = 'statements-import@stemwijzer.invalid');

INSERT INTO statements (text, created_by)
SELECT 'De overheid moet meer geld investeren in betaalbare woningen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De overheid moet meer geld investeren in betaalbare woningen.');

INSERT INTO statements (text, created_by)
SELECT 'Nederland moet strengere regels invoeren voor immigratie.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Nederland moet strengere regels invoeren voor immigratie.');

INSERT INTO statements (text, created_by)
SELECT 'Het minimumloon moet verder worden verhoogd.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Het minimumloon moet verder worden verhoogd.');

INSERT INTO statements (text, created_by)
SELECT 'De belastingen voor hoge inkomens moeten omhoog.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De belastingen voor hoge inkomens moeten omhoog.');

INSERT INTO statements (text, created_by)
SELECT 'Nederland moet meer geld uitgeven aan defensie.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Nederland moet meer geld uitgeven aan defensie.');

INSERT INTO statements (text, created_by)
SELECT 'Kernenergie moet een belangrijk onderdeel worden van de Nederlandse energievoorziening.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Kernenergie moet een belangrijk onderdeel worden van de Nederlandse energievoorziening.');

INSERT INTO statements (text, created_by)
SELECT 'De overheid moet sneller stoppen met het gebruik van fossiele brandstoffen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De overheid moet sneller stoppen met het gebruik van fossiele brandstoffen.');

INSERT INTO statements (text, created_by)
SELECT 'Boeren moeten strengere milieuregels krijgen om stikstofuitstoot te verminderen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Boeren moeten strengere milieuregels krijgen om stikstofuitstoot te verminderen.');

INSERT INTO statements (text, created_by)
SELECT 'Het openbaar vervoer moet goedkoper worden.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Het openbaar vervoer moet goedkoper worden.');

INSERT INTO statements (text, created_by)
SELECT 'Studenten moeten meer financiële ondersteuning krijgen van de overheid.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Studenten moeten meer financiële ondersteuning krijgen van de overheid.');

INSERT INTO statements (text, created_by)
SELECT 'De overheid moet meer geld investeren in de zorg.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De overheid moet meer geld investeren in de zorg.');

INSERT INTO statements (text, created_by)
SELECT 'Het eigen risico in de zorg moet worden afgeschaft.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Het eigen risico in de zorg moet worden afgeschaft.');

INSERT INTO statements (text, created_by)
SELECT 'Nederland moet meer vluchtelingen opvangen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Nederland moet meer vluchtelingen opvangen.');

INSERT INTO statements (text, created_by)
SELECT 'De politie moet meer bevoegdheden krijgen om criminaliteit te bestrijden.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De politie moet meer bevoegdheden krijgen om criminaliteit te bestrijden.');

INSERT INTO statements (text, created_by)
SELECT 'Cannabis moet volledig worden gelegaliseerd.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Cannabis moet volledig worden gelegaliseerd.');

INSERT INTO statements (text, created_by)
SELECT 'De maximumsnelheid op snelwegen moet overdag weer naar 130 km/u.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De maximumsnelheid op snelwegen moet overdag weer naar 130 km/u.');

INSERT INTO statements (text, created_by)
SELECT 'Bedrijven moeten meer belasting betalen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Bedrijven moeten meer belasting betalen.');

INSERT INTO statements (text, created_by)
SELECT 'Nederland moet meer bevoegdheden overdragen aan de Europese Unie.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Nederland moet meer bevoegdheden overdragen aan de Europese Unie.');

INSERT INTO statements (text, created_by)
SELECT 'Er moet een bindend referendum komen waarmee burgers direct over wetten kunnen stemmen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Er moet een bindend referendum komen waarmee burgers direct over wetten kunnen stemmen.');

INSERT INTO statements (text, created_by)
SELECT 'De overheid moet harder optreden tegen bedrijven die veel CO₂ uitstoten.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De overheid moet harder optreden tegen bedrijven die veel CO₂ uitstoten.');

INSERT INTO statements (text, created_by)
SELECT 'Vlees moet duurder worden om milieuschade te verminderen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Vlees moet duurder worden om milieuschade te verminderen.');

INSERT INTO statements (text, created_by)
SELECT 'De overheid moet gratis kinderopvang aanbieden.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De overheid moet gratis kinderopvang aanbieden.');

INSERT INTO statements (text, created_by)
SELECT 'Er moet meer geld naar onderwijs, ook als daarvoor andere overheidsuitgaven moeten worden verlaagd.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Er moet meer geld naar onderwijs, ook als daarvoor andere overheidsuitgaven moeten worden verlaagd.');

INSERT INTO statements (text, created_by)
SELECT 'Sociale media moeten strenger worden gereguleerd.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Sociale media moeten strenger worden gereguleerd.');

INSERT INTO statements (text, created_by)
SELECT 'Nederland moet de verkoop van nieuwe benzine- en dieselauto’s sneller verbieden.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Nederland moet de verkoop van nieuwe benzine- en dieselauto’s sneller verbieden.');

INSERT INTO statements (text, created_by)
SELECT 'Mensen met een uitkering moeten verplicht worden om passend werk te accepteren.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Mensen met een uitkering moeten verplicht worden om passend werk te accepteren.');

INSERT INTO statements (text, created_by)
SELECT 'De overheid moet meer geld besteden aan ontwikkelingshulp.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De overheid moet meer geld besteden aan ontwikkelingshulp.');

INSERT INTO statements (text, created_by)
SELECT 'De inkomstenbelasting moet omlaag.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De inkomstenbelasting moet omlaag.');

INSERT INTO statements (text, created_by)
SELECT 'Nederland moet minder afhankelijk worden van andere landen voor energie en grondstoffen.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'Nederland moet minder afhankelijk worden van andere landen voor energie en grondstoffen.');

INSERT INTO statements (text, created_by)
SELECT 'De overheid moet gezichtsherkenning mogen gebruiken om ernstige criminaliteit te bestrijden.', id FROM superadmins
WHERE email = 'statements-import@stemwijzer.invalid'
AND NOT EXISTS (SELECT 1 FROM statements WHERE text = 'De overheid moet gezichtsherkenning mogen gebruiken om ernstige criminaliteit te bestrijden.');

COMMIT;

