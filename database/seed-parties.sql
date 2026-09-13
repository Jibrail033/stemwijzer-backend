-- Fictieve testpartijen voor het CMS; herhaalbaar zonder dubbele partijen.
-- Geen bestaande politieke partijen; alleen om de CRUD- en matchingroutes te kunnen testen.
PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

INSERT INTO parties (name, description, image_url, is_active)
SELECT 'Partij voor Vooruitgang', 'Fictieve testpartij, gericht op economische groei en innovatie.', 'https://example.com/logos/vooruitgang.png', 1
WHERE NOT EXISTS (SELECT 1 FROM parties WHERE name = 'Partij voor Vooruitgang');

INSERT INTO parties (name, description, image_url, is_active)
SELECT 'Groene Toekomst Alliantie', 'Fictieve testpartij, gericht op klimaat en duurzaamheid.', 'https://example.com/logos/groene-toekomst.png', 1
WHERE NOT EXISTS (SELECT 1 FROM parties WHERE name = 'Groene Toekomst Alliantie');

INSERT INTO parties (name, description, image_url, is_active)
SELECT 'Liberaal Perspectief', 'Fictieve testpartij, gericht op individuele vrijheid en lagere belastingen.', 'https://example.com/logos/liberaal-perspectief.png', 1
WHERE NOT EXISTS (SELECT 1 FROM parties WHERE name = 'Liberaal Perspectief');

INSERT INTO parties (name, description, image_url, is_active)
SELECT 'Sociale Verbinding', 'Fictieve testpartij, gericht op sociale zekerheid en gelijkheid.', 'https://example.com/logos/sociale-verbinding.png', 1
WHERE NOT EXISTS (SELECT 1 FROM parties WHERE name = 'Sociale Verbinding');

INSERT INTO parties (name, description, image_url, is_active)
SELECT 'Nationaal Behoud', 'Fictieve testpartij, gericht op nationale soevereiniteit en veiligheid.', 'https://example.com/logos/nationaal-behoud.png', 1
WHERE NOT EXISTS (SELECT 1 FROM parties WHERE name = 'Nationaal Behoud');

INSERT INTO parties (name, description, image_url, is_active)
SELECT 'Voormalige Testpartij', 'Fictieve, niet meer actieve testpartij om is_active = 0 te kunnen controleren.', NULL, 0
WHERE NOT EXISTS (SELECT 1 FROM parties WHERE name = 'Voormalige Testpartij');

COMMIT;
