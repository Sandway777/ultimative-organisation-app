# Ordner für Claude Design

Alles, was Claude Design braucht, um Design-Entwürfe für den
**Ultimativen Notizblock** zu machen.

## Inhalt

| Datei | Wofür |
|---|---|
| `00-UEBERSICHT.md` | **Das Wichtigste.** Was die App ist, wie sie aufgebaut ist, alle Bereiche und Inhaltstypen, was gebraucht wird |
| `01-SCREENSHOTS.md` | Bildliste – was auf welchem Screenshot zu sehen ist |
| `03-IST-ZUSTAND-CSS.md` | aktuelle Farben, Schriften, Maße und was technisch geht |
| `06-WICHTIGES-HERVORHEBEN.md` | **Wichtig.** Was in der App hervorstechen muss – Warnungen, Hauptzahlen, Dringendes |
| `04-UMSCHALTBARKEIT.md` | **Wichtig.** Die Designs sollen per Knopf umschaltbar sein – was das für die Entwürfe heißt |
| `screenshots/` | 23 Bilder aus dem laufenden Programm, Handy und Desktop |

## Reihenfolge zum Lesen

1. `00-UEBERSICHT.md` – erst verstehen, was die App macht
2. `screenshots/` durchsehen, mit `01-SCREENSHOTS.md` daneben
3. `03-IST-ZUSTAND-CSS.md` – was technisch möglich ist
4. `06-WICHTIGES-HERVORHEBEN.md` – was ins Auge springen muss
5. `04-UMSCHALTBARKEIT.md` – warum alle Fassungen dieselben Token-Namen brauchen

## Was zurückkommen soll

Drei bis vier Design-Fassungen (je Handy **und** Desktop), die aus **einem
System** kommen: gleiche Token-Namen, andere Werte. Jede Fassung **einmal hell
und einmal dunkel**. Ich baue sie alle ein und schalte in der App per Knopf
zwischen ihnen um.

Dazu eine **Design-Spec als Textdatei**: ein Token-Verzeichnis mit einer
Spalte je Fassung, plus Komponentenregeln in Worten. Details in
`04-UMSCHALTBARKEIT.md`.

Diese Spec wird dann in Claude Code eingebaut.
