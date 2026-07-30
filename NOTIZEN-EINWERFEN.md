# Notizen einwerfen – so geht's

Für Claude Code gedacht. Leon schreibt hier im Projektordner einfach los,
Claude trägt die Punkte direkt in die App ein. Kein JSON, kein Copy-Paste,
kein API-Guthaben nötig – Claude sortiert selbst und schreibt in `index.html`.

## Für Leon: was du schreibst

Fang die Nachricht mit einem dieser Wörter an:

| Wort | Was passiert |
|---|---|
| **Ideen:** | kommt aufs Idee-Board, passend einsortiert |
| **Notizen:** | Claude sucht selbst den richtigen Bereich |
| **Heute:** / **Morgen:** | täglicher Notizzettel |
| **August:** (o.ä. Monat) | Monatszettel |

Danach einfach draufloschreiben – unsortiert, mit Tippfehlern, wie es kommt.
Mehrere Punkte durch Komma oder neue Zeile trennen. Beispiel:

```
Ideen: lokale KI testen, Cloudflare für Petivo, Steuerpodcast zu Ende gucken
```

Wenn unklar ist, wohin ein Punkt gehört, fragt Claude nach – aber nur dann.

## Für Claude: wie eintragen

Die Punkte gehören **nicht** in eine separate Datei, sondern in `index.html`.
Es gibt zwei Wege:

### Weg 1 – Übernahme-Funktion (für Sammlungen)

Nach dem Muster von `ideenUebernehmen()` / `umzugUebernehmen()`:

1. Eigene Funktion mit **eigenem Schlüssel** anlegen
   (`const XYZ_KEY = 'thema-JJJJ-MM-TT'`)
2. Erste Zeile prüft `data.uebernommen[KEY]` und bricht ab, wenn schon gelaufen
3. Am Ende Schlüssel setzen
4. Aufruf am Ende von `migrateData()` ergänzen – **nicht** in `load()`,
   sonst greift sie nicht, wenn der Stand aus der Cloud oder einer Sicherung kommt
5. Vorhandene Texte überspringen (`Set` mit `.toLowerCase().trim()`),
   damit nichts doppelt landet

### Weg 2 – direkt in die Beispiel-/Startdaten (selten)

Nur wenn es wirklich um Muster-Einträge geht, nicht um echte Inhalte.

### Danach immer

- Syntax prüfen:
  `node -e "new Function(require('fs').readFileSync('index.html','utf8').match(/<script>([\s\S]*)<\/script>/)[1])"`
- Die Übernahme isoliert testen (Funktion extrahieren, gegen ein Daten-Gerüst laufen lassen)
- Zweiten Lauf testen: muss `0` ergeben
- Prüfen, dass echte Daten unberührt bleiben
- Deutsch committen, Umlaute in der Commit-Message vermeiden

### Umlaute

Notizen kommen oft mit kaputter Kodierung an (`Ã¼` statt `ü`). Beim Übertragen
reparieren. Im Code selbst sind Umlaute richtig – nur Commit-Messages ohne.

## Wo was hingehört

| Inhalt | Ziel |
|---|---|
| Einfälle, Projektideen, "irgendwann mal" | Idee-Board (`data.ideaBoard`) |
| Behörden, Formulare, Fristen | Privat → Anträge (`privat:antraege`, Typ `deadlines`) |
| Umzug, Packen | Privat → Umzug (`privat:umzug`, Typ `moving`) |
| PETIVO, Shop, Marge | Business → Nächste Schritte / Optimierungen / Marge |
| Uni, Module, Prüfungen | Uni → passender Unterpunkt |
| Training, Kuren | Sport |
| An einem bestimmten Tag zu tun | `data.dailyNotes.days` |
| In einem bestimmten Monat zu tun | `data.months` (vier Spalten) |

Passt ein Punkt an mehrere Stellen, ist Doppeltragen in Ordnung: Der Monats-
oder Tageszettel ist der Plan, der Fachbereich hält den Ablauf dahinter fest.
