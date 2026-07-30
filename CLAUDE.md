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

- **Privat** – Reisen, Anträge, Ausgaben
- **Business** (PETIVO) – Nächste Schritte, Optimierungen, Marge
- **Uni** – Vor dem Start, Stundenplan, Prüfungstermine, Lernplan, Module & Noten
- **Sport und Gesundheit** – Trainingsübersicht, Kuren

Jede Säule hat eine eigene Akzentfarbe, die sich konsequent durchs ganze UI zieht
(Titel, Häkchen, Tags) – nicht nur als kleiner Punkt irgendwo.

Inhaltstypen: `checklist`, `trips`, `deadlines`, `expenses`, `ideas`, `margin`,
`timetable`, `exams`, `study`, `modules`.

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

## Speichern und Holen

`speichern.bat` committet mit zufälligem Titel plus Zeitstempel, holt erst den
Remote-Stand (`pull --rebase`) und pusht dann. `holen.bat` holt nur.

Beide Skripte prüfen vorher, ob überhaupt ein Remote verbunden ist, und melden es,
falls nicht – dann wird ausschließlich lokal gespeichert. Wenn ein Stand
scheinbar nicht auf GitHub landet, **zuerst `git remote -v` und `gh auth status`
prüfen**: ohne Remote und ohne Anmeldung kann kein Push stattfinden.
