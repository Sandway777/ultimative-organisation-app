# Ultimativer Notizblock – Spec für Claude Code

## Ziel
Persönliche Organisations-App, nur für einen Nutzer (Leon). Ersetzt viele verstreute Einzel-Notizdateien durch ein einheitliches System. Muss langfristig beliebig erweiterbar sein (z. B. später Einkaufslisten, weitere Bereiche).

## Architektur
- Echte App (PWA): installierbar auf Handy-Homescreen und Desktop, funktioniert offline.
- Speicherung Phase 1: lokal im Browser (IndexedDB/localStorage).
- Speicherung Phase 2: automatischer Sync über Microsoft OneDrive (Microsoft Graph API, OAuth-Login) – App liest/schreibt eine JSON-Datei in OneDrive, damit alle Geräte denselben Stand zeigen. Freier OneDrive-Speicher reicht locker.
- **Export/Import als JSON-Datei jederzeit verfügbar** – nicht verhandelbar, unabhängig vom Speicher-Backend, dient als Sicherheitsnetz.

## Bereiche (übergeordnet)
Privat / Business (PETIVO) / Uni – jeweils eigene Akzentfarbe (z. B. Terrakotta / Teal / Indigo), die sich konsequent durchs ganze UI zieht (Titel, Häkchen, Tags) – nicht nur ein kleiner Punkt irgendwo.

## Vier Inhaltstypen
Jeder Typ funktioniert und sieht anders aus, alle teilen sich aber ein gemeinsames Design-System (keine Insel-Optik):

1. **Idee-Board** – existiert nur einmal, immer vorhanden/angepinnt. Rohtext/Diktat rein → KI (Anthropic API, echter Call) zerlegt den Text in einzelne Punkte, ordnet sie bestehenden Kategorien zu oder schlägt neue vor (Emoji + Farbe). Pinnwand-Layout, ein Kärtchen pro Kategorie.
2. **Checkliste** – klassische Todo-Liste, beliebig oft anlegbar, mit Bereichs-Tag.
3. **Monatsübersicht** – ein Zettel pro Monat, 3 feste Spalten: Privat / Sport / Business, je eigener Fokus/eigene Punkte. Lösch- und neu anlegbar.
4. **Reiseplan** – ein Zettel pro Reise: Zeitraum (von–bis) oben, darunter Tages-Karten (keine breite Tabelle – auf Handy schlecht bedienbar), jede Karte mit eigener Mini-Checkliste.

## Vorbefüllte Startstruktur (wichtig – nicht als leere Hülle liefern!)
- **Uni**: eigene Checklisten für „Termine", „Stundenplan/Vorlesungen", „Prüfungstermine", „Lernplan/Vorbereitung"
- **Business**: Checkliste „Nächste Schritte PETIVO"
- **Privat**: keine festen Unterlisten nötig – abgedeckt über Idee-Board + Monatsübersicht + Reiseplan + frei anlegbare Checklisten (z. B. Jahresvorsätze, falls gewünscht)

## Navigation
- Seitenleiste: Legende aller Zettel, sortiert nach Datum, Typ als Icon, Bereich als Farbe.
- Bereich-Filter oben (Alle/Privat/Business/Uni): Klick öffnet eine **echte Übersichtsseite** mit anklickbaren Karten aller Zettel dieses Bereichs – kein stilles Filtern ohne sichtbare Reaktion.
- „+ Neuer Zettel": Titel, Typ, Bereich wählen. Bei Reiseplan wird der Zeitraum direkt abgefragt, Tageskarten werden automatisch erzeugt.

## Design-Sprache
- Editorial, ruhig, hochwertig: Fraunces (Serife, Überschriften) + IBM Plex Sans/Mono (Fließtext/Labels).
- Warmer Papier-Hintergrund, dunkle Seitenleiste.
- Bereichsfarben konsequent sichtbar überall, wo der jeweilige Bereich vorkommt – nicht nur als Detail.

## Nicht verhandelbar
- Export/Import als JSON, jederzeit, komplett unabhängig vom Speicherort.
- Leicht erweiterbar: neue Bereiche/Typen später ohne große Umbauten ergänzbar.
- Zuverlässige Klick-/Touch-Bedienung auf Mobilgeräten (kein reines Hover, alles muss auch per Tippen funktionieren).
