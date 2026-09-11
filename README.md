# Stemwijzer backend

Node.js and TypeScript starter using Betterjams' server compiler settings and ESLint rules, adapted to a standalone project. Requires Node.js 22.13 or newer.

## Getting started

```sh
npm install
npm start
```

The entry point is `src/index.ts`. It opens one shared database connection and starts the HTTP server on port 3000 (override with `PORT`). Development runs through ts-node and nodemon, restarting when source files change. If environment variables are needed, copy `.env.example` to `.env`; the development command loads it automatically.

## Commands

- `npm start` or `npm run dev`: start development with automatic restarts.
- `npm run build`: compile TypeScript into `dist`.
- `npm run start:prod`: run the compiled entry point. Set production environment variables in the hosting environment.
- `npm run typecheck`: check types without emitting files.
- `npm run lint`: check ESLint rules.
- `npm run lint:fix`: apply automatic ESLint fixes.

The ESLint configuration is copied from Betterjams, including its type-aware TypeScript rules and stylistic rules. TypeScript uses strict checking, ES2022, and CommonJS, matching its server. Build and lint tool versions are pinned to Betterjams' installed versions for consistent behavior.

## SQLite-database

Voer `npm run db:init` uit om `data/stemwijzer.sqlite` aan te maken. Dit kan opnieuw zonder bestaande gegevens te verwijderen. Het schema staat in `database/schema.sql` en bevat de vier tabellen uit het ERD: `superadmins`, `statements`, `parties` en `party_answers`.

Gebruik `openDatabase()` uit `src/database/index.ts` om vanuit de backend een verbinding te openen. Sluit de verbinding met `database.close()` wanneer deze niet meer nodig is. De verbinding schakelt foreign keys in en maakt ontbrekende tabellen aan. Dit gebruikt de ingebouwde [Node.js SQLite-module](https://nodejs.org/api/sqlite.html), zonder extra afhankelijkheden. Bij distributie moet de map `database` naast `dist` aanwezig blijven.

- `DATABASE_PATH` kan het standaardbestand overschrijven; relatieve paden zijn relatief aan de werkmap. De ontwikkel- en initialisatiecommando's lezen `.env`.
- ID's worden automatisch door SQLite gegenereerd met `INTEGER PRIMARY KEY`.
- `answer` wordt opgeslagen als tekst met een controle op `eens`, `neutraal` en `oneens`.
- `is_active` accepteert alleen `0` of `1` en staat standaard aan.
- `created_at` en `updated_at` gebruiken UTC-tijdstempels; wijzigingen aan inhoudelijke velden werken `updated_at` automatisch bij.
- `description` en `image_url` zijn optioneel; overige velden zijn verplicht of krijgen een standaardwaarde. De opgegeven maximale tekstlengtes worden gecontroleerd.
- Verwijderen van een record waarnaar nog wordt verwezen wordt geblokkeerd. Er worden geen gerelateerde records automatisch verwijderd.
- Zoals in het ERD is alleen `email` expliciet uniek naast de primaire sleutels; er is geen extra unieke beperking op partij/stelling-combinaties.
- `npm test` controleert het schema, de beperkingen en het statements-endpoint in een tijdelijke database in het geheugen.

De lokale database wordt niet in versiebeheer opgenomen. Initialisatie maakt geen accounts of voorbeeldgegevens aan. Wijzigingen aan bestaande tabellen vereisen later een migratie; `db:init` wijzigt geen bestaande tabeldefinities.

## Eén stelling ophalen

Start met `npm start` en vraag `GET http://localhost:3000/statements?index=0` op. `index` is verplicht en begint bij 0. Het is de positie binnen de actieve stellingen, gesorteerd op oplopend ID, niet het database-ID. Verhoog de index met 1 voor de volgende stelling. Als stellingen tussentijds worden verwijderd of gedeactiveerd, kunnen de posities verschuiven.

Voorbeeldantwoord met fictieve partijen:

```json
{
  "index": 0,
  "id": 1,
  "text": "De overheid moet meer geld investeren in betaalbare woningen.",
  "partyAnswers": [
    { "partyId": 1, "partyName": "Voorbeeldpartij A", "answer": "eens" },
    { "partyId": 2, "partyName": "Voorbeeldpartij B", "answer": null }
  ]
}
```

Alle actieve partijen worden meegenomen, gesorteerd op ID. `answer` is `eens`, `neutraal`, `oneens` of `null` als de partij nog geen antwoord heeft opgeslagen. Zonder actieve partijen is `partyAnswers` een lege lijst. Bij meerdere antwoorden van dezelfde partij op dezelfde stelling wordt het laatst bijgewerkte antwoord gebruikt; bij gelijke tijdstempels wint het hoogste antwoord-ID. De route wijzigt geen gegevens en vereist geen login.

- `200`: één stelling met partijantwoorden.
- `400`: ontbrekende, dubbele of ongeldige index; gebruik één niet-negatief, veilig geheel getal in decimale notatie, zonder voorloopnullen.
- `404`: geen actieve stelling op deze positie, of een onbekende route.
- `405`: gebruik GET; andere methoden zijn niet toegestaan.
- `500`: ophalen mislukt; details worden alleen op de server gelogd.

De query staat in `src/statements/get-statement.ts`, de indexvalidatie en response in `src/statements/index.ts`, en de HTTP-routering in `src/server.ts`. De server gebruikt de ingebouwde [Node.js HTTP-module](https://nodejs.org/api/http.html).

## Alle antwoorden in één keer matchen

Bewaar de keuzes in de frontend en stuur pas aan het einde één `POST http://localhost:3000/matching` met `Content-Type: application/json`. Gebruik het `id` uit het statements-endpoint als `statementId`, niet de navigatie-index. Iedere actieve stelling moet precies één antwoord krijgen. De huidige 30 actieve stellingen vereisen dus 30 antwoorden; tussentijdse, onvolledige inzendingen worden geweigerd.

Voorbeeld van de body voor een vragenlijst met twee actieve stellingen (bij de huidige database moet de lijst alle 30 antwoorden bevatten):

```json
{
  "answers": [
    { "statementId": 1, "answer": "eens" },
    { "statementId": 2, "answer": "neutraal" }
  ]
}
```

Aanroepen vanuit de frontend nadat alle keuzes zijn gemaakt:

```js
const response = await fetch('http://localhost:3000/matching', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ answers }),
});
const result = await response.json();
if (!response.ok) throw new Error(result.error);
// Toon result.matches.
```

Gebruik voor een frontend op een andere origin een ontwikkelproxy of dezelfde origin; er is nog geen CORS-configuratie.

Voorbeeldresultaat met een fictieve partij:

```json
{
  "totalAnswers": 30,
  "matches": [
    {
      "partyId": 1,
      "partyName": "Voorbeeldpartij",
      "matchPercentage": 80,
      "matchedAnswers": 24,
      "comparedAnswers": 30,
      "missingAnswers": 0
    }
  ]
}
```

De score is het aantal exact gelijke antwoorden gedeeld door het aantal vergelijkbare antwoorden, maal 100, afgerond op twee decimalen. `neutraal` komt alleen overeen met `neutraal`; alle stellingen wegen even zwaar. Ontbrekende partijantwoorden tellen niet mee in de noemer. Toon daarom ook `comparedAnswers` en `missingAnswers`: 100% op één antwoord is minder volledig dan 100% op alle 30 antwoorden. Bij nul vergelijkbare antwoorden is het percentage `null`.

Alleen actieve partijen tellen mee. Net als bij het statements-endpoint wordt bij dubbele partijantwoorden het laatst bijgewerkte antwoord gebruikt, met het hoogste antwoord-ID als beslissende waarde bij gelijke tijdstempels. De resultaten zijn gesorteerd op aflopend percentage, dan op aflopend aantal vergelijkbare antwoorden en vervolgens oplopend partij-ID. Partijen zonder score staan onderaan. Zonder actieve partijen is `matches` leeg.

De backend berekent de score zelf uit de database. Er worden geen gebruikersantwoorden opgeslagen, geen records toegevoegd en geen login of sessie vereist.

- `200`: alle partijresultaten in één response.
- `400`: ongeldige JSON, een lege of onvolledige antwoordenlijst, dubbele/onbekende/inactieve stelling-ID's of een antwoord buiten `eens`, `neutraal`, `oneens`. De volledige lijst wordt afgewezen; er wordt geen gedeeltelijk resultaat berekend.
- `405`: gebruik POST.
- `413`: body groter dan 64 KiB.
- `415`: Content-Type is geen `application/json`.
- `500`: berekenen mislukt; foutdetails blijven op de server.

De requestafhandeling staat in `src/matching/index.ts`, validatie in `src/matching/validation.ts` en de scoreberekening in `src/matching/match-results.ts`. `npm test` controleert ook matching, sortering, ontbrekende partijantwoorden en ongeldige inzendingen via HTTP, zonder de lokale database te wijzigen.

## Een partij aanmaken

Stuur `POST http://localhost:3000/parties` met `Content-Type: application/json`:

```json
{
  "name": "Voorbeeldpartij",
  "description": "Beschrijving van de partij.",
  "imageUrl": "https://example.com/logo.png",
  "isActive": true
}
```

Alleen `name` is verplicht. De naam wordt getrimd en moet 1 tot en met 100 Unicode-tekens bevatten. `description` is tekst of `null` en is standaard `null`. `imageUrl` is een absolute HTTP- of HTTPS-URL van maximaal 255 tekens of `null`; de URL wordt alleen opgeslagen en niet opgehaald. `isActive` is een boolean en is standaard `true`. Nultekens en onbekende velden worden geweigerd. ID's en tijdstempels worden door de database gegenereerd. Partijnamen hoeven volgens het ERD niet uniek te zijn; elk succesvol verzoek maakt een nieuwe partij aan.

Bij succes geeft de API `201 Created` terug met `id`, `name`, `description`, `imageUrl`, `isActive`, `createdAt` en `updatedAt`. Ongeldige gegevens of JSON geven `400`; een verkeerde methode geeft `405`, een body groter dan 64 KiB `413`, een verkeerd Content-Type `415`, en een databasefout `500`. De response bevat geen interne foutdetails. Aanmaken voegt alleen een partij toe, geen partijantwoorden.

De route heeft op dit moment, net als de rest van deze backend, geen authenticatie of beheerderscontrole. Deze toegangscontrole moet nog worden toegevoegd voor gebruik als afgeschermde beheerfunctie.

De code staat in `src/parties`, de interfaces in `src/types/party.interface.ts`. Partijen en matching delen JSON-verwerking via `src/http/read-json-body.ts`. `npm test` controleert succesvolle opslag, optionele velden, ongeldige invoer en foutafhandeling met een database in het geheugen.
