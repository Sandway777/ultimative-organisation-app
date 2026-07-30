# Ultimativer Notizblock – Projekt-Gedächtnis

Persönliche Organisations-App für einen einzigen Nutzer (Leon). Ersetzt viele
verstreute Notizdateien durch ein einheitliches System. PWA, installierbar,
offline-fähig.

**Sprache:** Alles auf Deutsch – UI-Texte, Commit-Messages, Kommentare im Code.

## Aufbau

Die ganze App ist **eine einzige Datei**: [index.html](index.html) (~3800 Zeilen,
ein `<script>`-Block). Kein Build, kein npm, keine Abhängigkeiten. Zum Testen
einfach die Datei im Browser öffnen.

| Datei | Zweck |
|---|---|
| [index.html](index.html) | Die komplette App (HTML + CSS + JS in einem) |
| [manifest.json](manifest.json) | PWA-Manifest (Homescreen-Installation) |
| [sw.js](sw.js) | Service Worker (Offline-Betrieb) |
| [speichern.bat](speichern.bat) | Stand committen + auf GitHub pushen |
| [holen.bat](holen.bat) | Neuesten Stand von GitHub holen |
| [notizblock-spec-fuer-claude-code.md](notizblock-spec-fuer-claude-code.md) | Ursprüngliche Spec – **teils veraltet**, siehe unten |
| [archiv/](archiv/) | Alte Prototypen, nur Referenz – nicht mehr anfassen |

## Datenhaltung

- Ein einziger localStorage-Key: `ultimativer-notizblock-v1`
- Zugriff läuft über den Shim `window.storage` ([index.html:813](index.html#L813)).
  **Wichtig:** Immer über diesen Shim gehen, nie direkt `localStorage` aufrufen –
  hier wird später der OneDrive-Sync eingehängt, ohne den Rest anzufassen.

## Struktur: vier Säulen

Definiert in der Konstante `STRUKTUR` ([index.html:830](index.html#L830)).
Die Unterpunkte sind **fest** – sie werden aus dem Bauplan erzeugt und können nicht
gelöscht werden. Angelegt und gelöscht wird immer nur *innerhalb* eines Unterpunkts.
Neue Unterpunkte ergänzt man in `STRUKTUR`; bestehende Daten bleiben erhalten.

- **Privat** – Reisen, Anträge, Ausgaben, Umzug
- **Business** (PETIVO) – Nächste Schritte, Optimierungen, Marge
- **Uni** – Vor dem Start, Stundenplan, Prüfungstermine, Lernplan, Module & Noten
- **Sport und Gesundheit** – Trainingsübersicht, Kuren

Jede Säule hat eine eigene Akzentfarbe, die sich konsequent durchs ganze UI zieht
(Titel, Häkchen, Tags) – nicht nur als kleiner Punkt irgendwo.

Inhaltstypen: `checklist`, `trips`, `deadlines`, `expenses`, `ideas`, `margin`,
`timetable`, `exams`, `study`, `modules`, `training`, `cures`.

Ein neuer Typ braucht vier Dinge: Eintrag in `STRUKTUR`, Default in
`emptyNodeContent`, ein Zweig im Dispatch von `renderMain`, plus Absicherung in
`migrateData` – sonst verlieren bestehende Nutzerdaten beim Typwechsel ihren Inhalt.

### Sport: Training und Kuren

- **Training** (`training`): **ein Wochenplan pro Monat**, Schlüssel `"YYYY-MM"`
  (`weeks: {"2026-07": {days:{0..6:[...]}}}`, Montag = 0). Der Monat wird per
  Auswahlfeld gewählt – **keine Wochen-Navigation, keine KW-Nummern**, Leon denkt
  nicht in Kalenderwochen. Ein leerer Monat bietet „Vormonat übernehmen"
  (kopiert, Häkchen zurückgesetzt), ein gefüllter „Plan löschen" (zwei Klicks).
  Drei Fokus-Bereiche in `TR_FOKUS`: Oberkörper, Bauch, Beine.
  Frühere Fassung nutzte ISO-Wochenschlüssel; `migrateData` legt alte Wochen in
  ihren Monat zusammen (Dubletten nach Text+Sätzen gefiltert), `isoWeekMonday`
  existiert nur noch dafür.
- **Kuren** (`cures`): **geführter Ablauf in Schritten**, nicht alles auf einmal:
  1. Neue Kur → nur der Name
  2. `renderCureSetup` – Schritt 1 Zeitraum, Schritt 2 Ablauf. Schritt 2
     bleibt gesperrt, bis der Zeitraum steht.

     **Pro Eintrag zwei Mehrfachauswahlen:** `zeiten: ['morgens','abends']` und
     `days: [0,2,4]` (leer = täglich). Eine Anwendung wird *einmal* eingetragen
     und kann mehrmals am Tag fällig sein – nicht dreimal anlegen für dreimal
     täglich. `cureSlotsForDay` erzeugt daraus die einzelnen Fälligkeiten
     (Schlüssel `anwendungId@tageszeit`), das ist die Einheit zum Abhaken.
  3. „Tabelle erstellen" → `renderCureTable`: Monatskalender plus Abhakliste des
     angeklickten Tages, Ablauf unten nur zum Nachlesen. Zurück über „Kur ändern"
     (`kurEinrichten[k.id]`).

  Die beiden Ansichten dürfen sich **nicht vermischen** – Einrichten und
  Abhaken sind getrennte Zustände. Eine Kur ohne Zeitraum oder ohne Ablauf
  startet immer im Einrichten-Schritt.
  `done: {"YYYY-MM-DD": {"anwendungId@tageszeit": true}}` – ältere Stände hakten
  nur je Anwendung ab (`{anwendungId: true}`), `cureIsDone` liest das weiter.
  Kalender-Zustände je Tag: erledigt, teilweise, versäumt, offen;
  Punkte = Anzahl Fälligkeiten.
  Heute gilt nie als versäumt – der Tag läuft noch. Fortschritt zählt nur bis
  heute, damit künftige Tage nicht als Versäumnis gelten.

Anzeigezustand (`trWeekSel`, `kurTagSel`) liegt bewusst außerhalb von `data` –
welche Woche gerade offen ist, gehört nicht in den Export.

## Datum: nie toISOString()

`toISOString()` rechnet nach UTC um und liefert in unserer Zeitzone (UTC+1/+2)
für Mitternacht **noch den Vortag**. Für Datums-Schlüssel immer `isoLocal(d)`
bzw. `isoToday()` benutzen. Diese Falle hatte sowohl die Kur-Tagesliste als auch
den täglichen Notizzettel betroffen (behoben am 30.07.2026).

## Design-Sprache

- Editorial, ruhig, hochwertig
- Fraunces (Serife) für Überschriften, IBM Plex Sans/Mono für Text und Labels
- Warmer Papier-Hintergrund, dunkle Seitenleiste

## Nicht verhandelbar

- **Export/Import als JSON**, jederzeit, unabhängig vom Speicherort – das
  Sicherheitsnetz. Darf nie wegfallen.
- **Touch-Bedienung muss funktionieren.** Kein reines Hover – alles muss auch per
  Tippen erreichbar sein. Wird primär am Handy benutzt.
- **Leicht erweiterbar** – neue Säulen und Typen ohne großen Umbau ergänzbar.
- Sichtbare Reaktion auf Klicks. Kein stilles Filtern ohne Rückmeldung.

## Stand: was noch fehlt

- **OneDrive-Sync** (Spec Phase 2, Microsoft Graph API + OAuth) – noch nicht gebaut.
  Einhängepunkt ist der `window.storage`-Shim.
- **Anthropic-API-Call fürs Idee-Board** – Rohtext/Diktat soll per KI in einzelne
  Punkte zerlegt und Kategorien zugeordnet werden. Noch nicht implementiert.

Die Spec-Datei beschreibt außerdem noch die ursprünglichen vier Inhaltstypen und
nennt Sport nicht als eigene Säule – die App ist dort inzwischen weiter. Bei
Widersprüchen gilt der Code, nicht die Spec.

**Reihenfolge laut Leon (30.07.2026):** Erst die App inhaltlich fertig bauen und
die wichtigsten bestehenden Notizen übertragen – der OneDrive-Sync kommt bewusst
zuletzt. Bis dahin liegen die Inhalte nur im Browser des jeweiligen Geräts, der
JSON-Export ist also das einzige Backup der Daten.

## Speichern und Holen

`speichern.bat` committet mit zufälligem Titel plus Zeitstempel, holt erst den
Remote-Stand (`pull --rebase`) und pusht dann. `holen.bat` holt nur.

Beide Skripte prüfen vorher, ob überhaupt ein Remote verbunden ist, und melden es,
falls nicht – dann wird ausschließlich lokal gespeichert. Wenn ein Stand
scheinbar nicht auf GitHub landet, **zuerst `git remote -v` und `gh auth status`
prüfen**: ohne Remote und ohne Anmeldung kann kein Push stattfinden.

Remote: `https://github.com/Sandway777/ultimative-organisation-app.git`

### Historie: zwei getrennte Anfänge (Juli 2026)

Das lokale Repo wurde ursprünglich per `git init` neu angelegt, statt das
bestehende GitHub-Repo zu klonen. Dadurch hatten beide Seiten **keinen gemeinsamen
Vorfahren** – der Grund, warum `git pull --rebase` im Skript nie funktionieren
konnte und der lokale Stand monatelang nicht in der Cloud landete.

Aufgelöst am 30.07.2026: Der lokale Stand (3831 Zeilen, 10 Inhaltstypen, vier
Säulen) war deutlich weiter als der GitHub-Stand (982 Zeilen, 3 Typen) und wurde
zur neuen Wahrheit auf `main`. Der alte GitHub-Stand liegt weiterhin im Branch
**`alter-stand-github`** – nicht löschen, das ist das Sicherheitsnetz.

