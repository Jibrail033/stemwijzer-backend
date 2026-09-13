-- Voorbeeldstandpunten van fictieve partijen op de stellingen uit seed-statements.sql.
-- Herhaalbaar zonder dubbele antwoorden; vereist dat seed-parties.sql en seed-statements.sql al zijn uitgevoerd.
PRAGMA foreign_keys = ON;
BEGIN IMMEDIATE;

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De overheid moet meer geld investeren in betaalbare woningen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Nederland moet strengere regels invoeren voor immigratie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Het minimumloon moet verder worden verhoogd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De belastingen voor hoge inkomens moeten omhoog.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Nederland moet meer geld uitgeven aan defensie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Kernenergie moet een belangrijk onderdeel worden van de Nederlandse energievoorziening.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De overheid moet sneller stoppen met het gebruik van fossiele brandstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Boeren moeten strengere milieuregels krijgen om stikstofuitstoot te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Het openbaar vervoer moet goedkoper worden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Studenten moeten meer financiële ondersteuning krijgen van de overheid.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De overheid moet meer geld investeren in de zorg.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Het eigen risico in de zorg moet worden afgeschaft.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Nederland moet meer vluchtelingen opvangen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De politie moet meer bevoegdheden krijgen om criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Cannabis moet volledig worden gelegaliseerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De maximumsnelheid op snelwegen moet overdag weer naar 130 km/u.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Bedrijven moeten meer belasting betalen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Nederland moet meer bevoegdheden overdragen aan de Europese Unie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Er moet een bindend referendum komen waarmee burgers direct over wetten kunnen stemmen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De overheid moet harder optreden tegen bedrijven die veel CO₂ uitstoten.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Vlees moet duurder worden om milieuschade te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De overheid moet gratis kinderopvang aanbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Er moet meer geld naar onderwijs, ook als daarvoor andere overheidsuitgaven moeten worden verlaagd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Sociale media moeten strenger worden gereguleerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Nederland moet de verkoop van nieuwe benzine- en dieselauto’s sneller verbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Mensen met een uitkering moeten verplicht worden om passend werk te accepteren.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De overheid moet meer geld besteden aan ontwikkelingshulp.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De inkomstenbelasting moet omlaag.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'Nederland moet minder afhankelijk worden van andere landen voor energie en grondstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Partij voor Vooruitgang' AND statements.text = 'De overheid moet gezichtsherkenning mogen gebruiken om ernstige criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De overheid moet meer geld investeren in betaalbare woningen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Nederland moet strengere regels invoeren voor immigratie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Het minimumloon moet verder worden verhoogd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De belastingen voor hoge inkomens moeten omhoog.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Nederland moet meer geld uitgeven aan defensie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Kernenergie moet een belangrijk onderdeel worden van de Nederlandse energievoorziening.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De overheid moet sneller stoppen met het gebruik van fossiele brandstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Boeren moeten strengere milieuregels krijgen om stikstofuitstoot te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Het openbaar vervoer moet goedkoper worden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Studenten moeten meer financiële ondersteuning krijgen van de overheid.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De overheid moet meer geld investeren in de zorg.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Het eigen risico in de zorg moet worden afgeschaft.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Nederland moet meer vluchtelingen opvangen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De politie moet meer bevoegdheden krijgen om criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Cannabis moet volledig worden gelegaliseerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De maximumsnelheid op snelwegen moet overdag weer naar 130 km/u.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Bedrijven moeten meer belasting betalen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Nederland moet meer bevoegdheden overdragen aan de Europese Unie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Er moet een bindend referendum komen waarmee burgers direct over wetten kunnen stemmen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De overheid moet harder optreden tegen bedrijven die veel CO₂ uitstoten.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Vlees moet duurder worden om milieuschade te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De overheid moet gratis kinderopvang aanbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Er moet meer geld naar onderwijs, ook als daarvoor andere overheidsuitgaven moeten worden verlaagd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Sociale media moeten strenger worden gereguleerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Nederland moet de verkoop van nieuwe benzine- en dieselauto’s sneller verbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Mensen met een uitkering moeten verplicht worden om passend werk te accepteren.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De overheid moet meer geld besteden aan ontwikkelingshulp.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De inkomstenbelasting moet omlaag.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'Nederland moet minder afhankelijk worden van andere landen voor energie en grondstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Groene Toekomst Alliantie' AND statements.text = 'De overheid moet gezichtsherkenning mogen gebruiken om ernstige criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De overheid moet meer geld investeren in betaalbare woningen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Nederland moet strengere regels invoeren voor immigratie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Het minimumloon moet verder worden verhoogd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De belastingen voor hoge inkomens moeten omhoog.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Nederland moet meer geld uitgeven aan defensie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Kernenergie moet een belangrijk onderdeel worden van de Nederlandse energievoorziening.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De overheid moet sneller stoppen met het gebruik van fossiele brandstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Boeren moeten strengere milieuregels krijgen om stikstofuitstoot te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Het openbaar vervoer moet goedkoper worden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Studenten moeten meer financiële ondersteuning krijgen van de overheid.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De overheid moet meer geld investeren in de zorg.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Het eigen risico in de zorg moet worden afgeschaft.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Nederland moet meer vluchtelingen opvangen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De politie moet meer bevoegdheden krijgen om criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Cannabis moet volledig worden gelegaliseerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De maximumsnelheid op snelwegen moet overdag weer naar 130 km/u.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Bedrijven moeten meer belasting betalen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Nederland moet meer bevoegdheden overdragen aan de Europese Unie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Er moet een bindend referendum komen waarmee burgers direct over wetten kunnen stemmen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De overheid moet harder optreden tegen bedrijven die veel CO₂ uitstoten.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Vlees moet duurder worden om milieuschade te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De overheid moet gratis kinderopvang aanbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Er moet meer geld naar onderwijs, ook als daarvoor andere overheidsuitgaven moeten worden verlaagd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Sociale media moeten strenger worden gereguleerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Nederland moet de verkoop van nieuwe benzine- en dieselauto’s sneller verbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Mensen met een uitkering moeten verplicht worden om passend werk te accepteren.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De overheid moet meer geld besteden aan ontwikkelingshulp.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De inkomstenbelasting moet omlaag.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'Nederland moet minder afhankelijk worden van andere landen voor energie en grondstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Liberaal Perspectief' AND statements.text = 'De overheid moet gezichtsherkenning mogen gebruiken om ernstige criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Nederland moet strengere regels invoeren voor immigratie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Het minimumloon moet verder worden verhoogd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De belastingen voor hoge inkomens moeten omhoog.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Kernenergie moet een belangrijk onderdeel worden van de Nederlandse energievoorziening.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De overheid moet sneller stoppen met het gebruik van fossiele brandstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Boeren moeten strengere milieuregels krijgen om stikstofuitstoot te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Studenten moeten meer financiële ondersteuning krijgen van de overheid.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De overheid moet meer geld investeren in de zorg.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Het eigen risico in de zorg moet worden afgeschaft.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De politie moet meer bevoegdheden krijgen om criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Cannabis moet volledig worden gelegaliseerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De maximumsnelheid op snelwegen moet overdag weer naar 130 km/u.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Nederland moet meer bevoegdheden overdragen aan de Europese Unie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Er moet een bindend referendum komen waarmee burgers direct over wetten kunnen stemmen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De overheid moet harder optreden tegen bedrijven die veel CO₂ uitstoten.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De overheid moet gratis kinderopvang aanbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Er moet meer geld naar onderwijs, ook als daarvoor andere overheidsuitgaven moeten worden verlaagd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Sociale media moeten strenger worden gereguleerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'Mensen met een uitkering moeten verplicht worden om passend werk te accepteren.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De overheid moet meer geld besteden aan ontwikkelingshulp.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De inkomstenbelasting moet omlaag.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Sociale Verbinding' AND statements.text = 'De overheid moet gezichtsherkenning mogen gebruiken om ernstige criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De overheid moet meer geld investeren in betaalbare woningen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Nederland moet strengere regels invoeren voor immigratie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Het minimumloon moet verder worden verhoogd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De belastingen voor hoge inkomens moeten omhoog.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Nederland moet meer geld uitgeven aan defensie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Kernenergie moet een belangrijk onderdeel worden van de Nederlandse energievoorziening.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De overheid moet sneller stoppen met het gebruik van fossiele brandstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Boeren moeten strengere milieuregels krijgen om stikstofuitstoot te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Het openbaar vervoer moet goedkoper worden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Studenten moeten meer financiële ondersteuning krijgen van de overheid.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De overheid moet meer geld investeren in de zorg.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Het eigen risico in de zorg moet worden afgeschaft.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Nederland moet meer vluchtelingen opvangen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De politie moet meer bevoegdheden krijgen om criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Cannabis moet volledig worden gelegaliseerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De maximumsnelheid op snelwegen moet overdag weer naar 130 km/u.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Bedrijven moeten meer belasting betalen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Nederland moet meer bevoegdheden overdragen aan de Europese Unie.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Er moet een bindend referendum komen waarmee burgers direct over wetten kunnen stemmen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De overheid moet harder optreden tegen bedrijven die veel CO₂ uitstoten.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Vlees moet duurder worden om milieuschade te verminderen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De overheid moet gratis kinderopvang aanbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Er moet meer geld naar onderwijs, ook als daarvoor andere overheidsuitgaven moeten worden verlaagd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Sociale media moeten strenger worden gereguleerd.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Nederland moet de verkoop van nieuwe benzine- en dieselauto’s sneller verbieden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Mensen met een uitkering moeten verplicht worden om passend werk te accepteren.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De overheid moet meer geld besteden aan ontwikkelingshulp.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'eens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De inkomstenbelasting moet omlaag.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'oneens'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'Nederland moet minder afhankelijk worden van andere landen voor energie en grondstoffen.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

INSERT INTO party_answers (party_id, statement_id, answer)
SELECT parties.id, statements.id, 'neutraal'
FROM parties, statements
WHERE parties.name = 'Nationaal Behoud' AND statements.text = 'De overheid moet gezichtsherkenning mogen gebruiken om ernstige criminaliteit te bestrijden.'
AND NOT EXISTS (
  SELECT 1 FROM party_answers
  WHERE party_answers.party_id = parties.id AND party_answers.statement_id = statements.id
);

COMMIT;
