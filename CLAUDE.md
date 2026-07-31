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
| [NOTIZEN-EINWERFEN.md](NOTIZEN-EINWERFEN.md) | Wie Leon hier Notizen einwirft und wie sie eingetragen werden |
| [notizblock-spec-fuer-claude-code.md](notizblock-spec-fuer-claude-code.md) | Ursprüngliche Spec – **teils veraltet**, siehe unten |
| [archiv/](archiv/) | Alte Prototypen, nur Referenz – nicht mehr anfassen |

## Datenhaltung

- Ein einziger localStorage-Key: `ultimativer-notizblock-v1`
- Zugriff läuft über den Shim `window.storage`.
  **Wichtig:** Immer über diesen Shim gehen, nie direkt `localStorage` aufrufen –
  dort hängt der Cloud-Sync.

### Cloud-Sync (GitHub Gist)

Statt OneDrive – kostenlos, kein Azure-Portal, Leon hat den Account schon.
Der komplette Datenstand liegt als **private Gist-Datei** `notizblock-daten.json`.

- Lokal wird sofort gespeichert, der Upload folgt 2 s später (`cloudPlan`).
  Die App bleibt dadurch schnell und offline nutzbar.
- Beim Start, beim Zurückkehren zum Tab und bei „wieder online" wird geholt
  (`cloudAbgleich`) – **der Cloud-Stand gewinnt**.
- Zweites Gerät: denselben Token eingeben, `cloudGistFinden` sucht die Datei
  im Konto. Keine Ids abtippen.
- **Zugangsdaten liegen in einem eigenen Key** (`notizblock-cloud-cfg`), damit
  Token und Gist-Id nie im JSON-Export landen. Das ist bewusst so – nicht
  zusammenlegen.
- Kein Speicher-Knopf. Leon will nichts drücken müssen.

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
`timetable`, `exams`, `study`, `modules`, `training`, `cures`, `moving`, `clients`.

Ein neuer Typ braucht vier Dinge: Eintrag in `STRUKTUR`, Default in
`emptyNodeContent`, ein Zweig im Dispatch von `renderMain`, plus Absicherung in
`migrateData` – sonst verlieren bestehende Nutzerdaten beim Typwechsel ihren Inhalt.

### Privat: Umzug

`moving` – war ursprünglich eine flache `checklist`, das trug die Notizen nicht:
ein Umzug hat einen Termin, Sachen die vorher erledigt sein müssen, das Packgut
und alles was danach ansteht. Deshalb **drei feste Phasen** (`UMZUG_PHASEN`:
vorher / packen / nachher) mit **frei benennbaren Gruppen** darin
(`gruppen: [{id, phase, title, items, zu}]`). Die Phasen bilden den zeitlichen
Ablauf ab und stehen fest; die Gruppen legt Leon selbst an – seine Notizen waren
schon so gegliedert (Technik, Klamotten, Dokumente …).

Oben stehen drei Datumsfelder (`datum`, `packVon`, `packBis`); aus `datum`
entsteht der Countdown in der Kopfzeile. Gruppen sind einzeln zuklappbar (`zu`) –
eine Packliste mit 30 Punkten will man nicht am Stück sehen. Gruppe löschen
braucht zwei Klicks.

`migrateData` wandelt eine alte flache Liste in eine Gruppe „Übernommen" unter
*Vor dem Umzug* um, Häkchen bleiben erhalten.

### Business: Kunden Design

`clients` – Nachweis, wie viele Designs pro Jahr entstanden sind und **auf
welchem Gerät**. Letzteres ist der eigentliche Zweck: beim Suchen einer alten
Datei zählt, ob sie auf dem Main PC oder dem Laptop liegt.

`jahre: {"2026": {kunden:[{id, nr, geraet, name}], zu}}` – ein Block je Jahr,
neueste zuerst, ältere zugeklappt. Geräte stehen in `GERAETE` (pc / laptop).

**Zwei Darstellungen, automatisch gewählt:** Solange kein Kunde einen Namen
trägt, erscheinen sie als **Raster kleiner Kacheln** (Nummer + PC/LT) – 26
Zeilen „ohne Namen" untereinander wären nur Scrollerei. Sobald irgendwo ein
Name steht, wechselt der Block auf die Listenform. Ein Tipp auf Kachel oder
Geräte-Knopf schaltet zwischen den Geräten um.

Löschen geht im Raster nur beim **letzten** Eintrag, damit die Nummern
fortlaufend bleiben; `kdNeuNummerieren` zieht danach nach.

Stand bei Anlage (31.07.2026): 2025 = 36 Kunden, alle PC. 2026 = 26 Kunden,
davon Nr. 26 auf dem Laptop.

### Uni: Module und Wahlpflicht

In `uni:module` steht der **komplette Studienverlauf Medizininformatik**
(TH Brandenburg, Stand 24.06.2025): alle 6 Semester, 36 Module, zusammen genau
180 CP – die Summe ist die Probe, ob der Plan vollständig ist. Alles startet auf
`status:'offen'`; Credits-Balken und gewichteter Notenschnitt rechnen sich daraus.

Über der Tabelle liegt `modSemesterLeiste()` – eine schmale Kachel je Semester
mit CP, Fortschritt und Anzahl offener Module. Bewusst **keine zweite Ansicht**:
die App soll klein bleiben, die Tabelle bleibt die Wahrheit.

**Wahlpflichtmodule** (`wahl:true`) stehen als Platzhalter drin – „WPF I–III"
und zweimal „WP Studium Generale" mit ihren 5 CP, damit die Rechnung von Anfang
an stimmt. Ein Klick auf die „Wahl"-Marke klappt das Angebot aus `WPF_ANGEBOT`
auf, ein Klick wählt aus – Name **und CP** werden gesetzt, `wahl` fällt auf
`false`. Kein eigener Bereich, keine Parallelliste.

Zwei getrennte Töpfe: `fach` (10 Module, alle 5 CP) und `generale` (8 Module).
`wtopf` am Modul merkt sich die Herkunft, damit nach der Wahl noch erkennbar
ist, woher es stammt; `wpfTopf()` leitet sie beim Anlegen aus dem Namen ab.

**Falle:** Im Studium Generale haben die meisten Module nur **2,5 CP** – wählt
Leon dort eines, fehlen ihm 2,5 CP und er bräuchte ein zweites. Die
Semester-Leiste prüft darum die **Gesamtsumme gegen `zielCp`** und blendet einen
Hinweis ein, sobald sie darunter fällt. Nicht je Semester prüfen: im Regelplan
hat das 1. Semester 29 CP und das 3. hat 31, das ist korrekt.

Dubletten werden über **Semester + Name** erkannt, mit Zähler – „WP Studium
Generale" kommt im 5. Semester zweimal vor und darf nicht zusammenfallen.

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

## Verschachteln statt auflisten – die wichtigste Regel

**Alles wird so weit eingebettet wie möglich.** Das ist keine Stilfrage, sondern
die Grundregel der App: Leon soll auf einen Blick verstehen, was zusammengehört,
ohne Spalten zu vergleichen.

Steckt in den Daten eine Hierarchie, muss sie **in der Ansicht sichtbar** sein –
als Gruppe mit Überschrift, in die die Einträge eingebettet sind. Eine flache
Liste mit einer Spalte „Semester" oder „Kategorie" ist genau das Falsche: die
Zugehörigkeit steht dann nur als Text daneben, statt sichtbar zu sein.

| Statt | Richtig |
|---|---|
| Tabelle mit Spalte „Semester" | Block „1. Semester" mit den Modulen darin |
| Liste mit Spalte „Bereich" | Gruppe je Bereich |
| alles untereinander | zusammengehörige Blöcke, einzeln zuklappbar |

Vorbilder im Code: `renderMoving` (Phasen → Gruppen → Punkte) und
`renderModules` (Semester → Module). Beide klappen pro Block zu – lange Listen
sollen am Handy nicht am Stück scrollen.

**Farbe gehört dazu, sparsam und mit Bedeutung.** Jede Säule hat ihre Akzentfarbe;
sie markiert Überschriften, Fortschritt und Zustände (offen / läuft / fertig).
Kein Schmuck ohne Aussage, aber auch kein farbloses Grau-in-Grau: Wo ein Zustand
wichtig ist, muss man ihn sehen, nicht lesen.

Anfängerfreundlich heißt hier: ruhig, wenig gleichzeitig sichtbar, klare
Überschriften, und das Wichtigste zuerst.

## Nicht verhandelbar

- **Export/Import als JSON**, jederzeit, unabhängig vom Speicherort – das
  Sicherheitsnetz. Darf nie wegfallen.
- **Touch-Bedienung muss funktionieren.** Kein reines Hover – alles muss auch per
  Tippen erreichbar sein. Wird primär am Handy benutzt.
- **Leicht erweiterbar** – neue Säulen und Typen ohne großen Umbau ergänzbar.
- Sichtbare Reaktion auf Klicks. Kein stilles Filtern ohne Rückmeldung.

## Notizen einwerfen

Leon schreibt hier in Claude Code „Ideen: …" oder „Notizen: …", Claude sortiert
und trägt direkt in `index.html` ein. Ablauf und Muster stehen in
[NOTIZEN-EINWERFEN.md](NOTIZEN-EINWERFEN.md).

Das ersetzt die frühere KI-Sortierung im Board: Leon hat Claude Pro, aber
**kein API-Guthaben** (Abo ≠ API-Zugang), der Anthropic-Call aus dem Browser
schied damit aus. Der JSON-Import (`ib-import`) war der Zwischenschritt und ist
seit 30.07.2026 raus – Claude Code kann die Datei direkt schreiben, damit
entfallen sowohl API als auch Copy-Paste.

Übernahmen laufen als eigene Funktion mit eigenem Schlüssel in
`data.uebernommen`, aufgerufen am Ende von `migrateData()` (nicht in `load()`,
sonst greifen sie nicht bei Cloud- oder Sicherungsständen).

## Stand: was noch fehlt

**Alles muss kostenlos bleiben** – das ist gesetzt. Keine Dienste vorschlagen,
die eine Kreditkarte verlangen oder nach einer Testphase Geld kosten.

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

