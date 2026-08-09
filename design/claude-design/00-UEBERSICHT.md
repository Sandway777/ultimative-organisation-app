# Ultimativer Notizblock – was drin ist

Bitte mehrere Design-Entwürfe für diese App. Sie ist fertig gebaut und läuft;
gesucht ist eine bessere **Optik**, nicht neue Funktionen. Ich habe **keine
festgelegte Richtung** – zeig mir gern verschiedene Handschriften.

## Was das für eine App ist

Persönliche Organisations-App für **einen einzigen Nutzer**. Kein Team, kein
Login, keine Fremden. Ersetzt viele verstreute Notizdateien. Alles auf Deutsch.

**Benutzt wird sie zu 90 % am iPhone**, hochkant, oft im Stehen und
nebenbei. Entwürfe bitte zuerst fürs Handy denken.

**Der Desktop muss aber mitkommen.** Er ist das Zweitgerät – dort wird
getippt, wenn viel einzutragen ist (Belege, Module, Packlisten). Heute läuft
dort im Grunde dieselbe schmale Spalte, nur breiter; die Fläche wird kaum
genutzt. Ob dort mehr nebeneinander gehört oder ob die ruhige Spalte richtig
ist, entscheidet ihr – aber der Desktop soll nicht wie ein Nachgedanke
aussehen. Bitte je Entwurf **beide Breiten** zeigen.

## Technik – bitte zuerst lesen

**Kein React, kein Tailwind, kein shadcn, kein npm, kein Build.**

Die ganze App ist **eine einzige `index.html`**: HTML, CSS und JavaScript in
einer Datei, alles von Hand geschrieben. Etwa 8.700 Zeilen. Man öffnet die
Datei im Browser, fertig. Sie läuft als PWA offline vom Homescreen.

Das heißt für die Entwürfe:

- Umsetzbar sein muss alles in **reinem CSS** – Custom Properties, Flexbox,
  Grid, `@media`. Das ist reichlich, aber es gibt keine Utility-Klassen und
  keine Komponentenbibliothek, aus der ich etwas ziehen könnte.
- Schriften kommen über Google Fonts, sonst keine externen Abhängigkeiten.
- Keine Icon-Bibliothek – ich benutze **Emoji** als Icons (👥 🏠 🎓 💪 …).
  Wenn ein Entwurf das ändern will, bitte sagen wie.
- Kein Dark-/Light-Umschalter vorhanden; aktuell nur eine feste Fassung.

## Aufbau: Seitenleiste + Hauptfläche

Links eine dunkle Navigation mit **vier Säulen**, jede mit eigener Akzentfarbe.
Jede Säule hat feste Unterpunkte. Klickt man einen an, füllt sein Inhalt die
Hauptfläche.

| Säule | Farbe jetzt | Unterpunkte |
|---|---|---|
| **Privat** | Terrakotta `#E08060` | Reisen · Anträge · Ausgaben · Umzug |
| **Business** (Firma PETIVO) | Petrol `#4FA8A2` | Nächste Schritte · Optimierungen · Marge · Kunden Design · Geschäftskonto |
| **Uni** (Medizininformatik) | Blauviolett `#8494CC` | Vor dem Start · Stundenplan · Prüfungstermine · Lernplan · Module & Noten · Semesterkosten |
| **Sport und Gesundheit** | Grün `#7FB169` | Trainingsübersicht · Kuren |

Dazu **vier Hauptbereiche** außerhalb der Säulen:

- **Monatsübersicht** – was dieser Monat bringt, nach Säulen sortiert
- **Ideenboard** – ungeordnete Einfälle, Farbe Gold `#D9A648`
- **Notizzettel** – Farbe Altrosa `#A06F94`; zweistufig: erst wählen *wohin*
  (Tages-To-dos oder Sammelliste „Ohne Termin"), dann schreiben
- **Ziele** – ebenfalls zweistufig: Jahresziele oder Lebensziele

## Die 16 Inhaltstypen

Das ist der eigentliche Umfang – jeder Typ sieht anders aus:

| Typ | Was es zeigt |
|---|---|
| `checklist` | einfache Hakenliste |
| `trips` | Reisen mit Zeitraum |
| `deadlines` | Anträge mit Frist, Ampel je nach Restzeit |
| `expenses` | **der größte Brocken**, siehe unten |
| `ideas` | Ideen, lose Karten |
| `margin` | Marge: Einkauf/Verkauf/Gewinn |
| `timetable` | Stundenplan, Wochenraster |
| `exams` | Prüfungen mit Datum |
| `study` | Lernplan |
| `modules` | 36 Uni-Module in 6 Semester-Blöcken, CP-Balken, Notenschnitt |
| `training` | ein Wochenplan pro Monat, Mo–So, drei Fokus-Bereiche |
| `cures` | Kuren: Monatskalender + Abhakliste je Tag |
| `moving` | Umzug: 3 Phasen → frei benannte Gruppen → Punkte |
| `clients` | Kundendesigns je Jahr, als Kachelraster oder Liste |
| `unikosten` | Semesterkosten je Semester |
| `bizkonto` | Geschäftskonto mit laufenden Abbuchungen |

## Der Ausgaben-Bereich (wichtigster Bildschirm)

Hier schaue ich am häufigsten drauf. Ganz oben **drei Kacheln**:

1. **Dieser Monat kostet dich** – z. B. 1.435,70 €
2. **Mein Geld** – was vom Budget übrig ist
3. **Wohnungseinrichtung** – 10.000 €, aufgeteilt in zwei Hälften à 5.000 €
   (meine und die meiner Freundin)

Jede Kachel ist **aufklappbar** und zeigt dann ihre komplette Rechnung Zeile
für Zeile. Wichtig: ich muss nachvollziehen können, welche Zahlen verrechnet
wurden – ohne das vertraue ich der Anzeige nicht.

Darunter zwei Oberbereiche mit Töpfen darin:

- **👥 Gemeinsam** (wird durch zwei geteilt): Wohnen · Essen (mit Budget
  350 €) · Sonstiges gemeinsam
- **🙋 Privat** (trage ich allein): Fixkosten · Sonstige Ausgaben ·
  Gadgets & Ausrüstung

Bei Budget-Töpfen läuft ein Balken mit: geplant gegen tatsächlich ausgegeben.

## Ziele

**Jahresziele** sind messbar, mit Zielwert und Stand. Der Fortschritt wird
gegen den **verstrichenen Anteil des Jahres** verglichen – daraus entsteht
„im Plan" oder „30 % hinten". Der Balken wird rot, wenn ich zurückliege.
Hochgezählt wird mit +/− statt Tippen.

**Lebensziele** haben kein Datum – dort zählt der **nächste Schritt**, der
auch zugeklappt sichtbar bleibt. Dazu ein Feld „Warum das?".

Beide tragen einen von **elf Lebensbereichen**, nach denen gruppiert wird:
Privat · Business · Uni · Finanzen · Körper · Gesundheit · Geistige
Entwicklung · Wissen · Spiritualität · Beziehungen · Sport.

## Wie es jetzt aussieht

Dunkel, warm-neutral, ruhig. **Fraunces** (Serife) für Überschriften,
**IBM Plex Sans/Mono** für Text und kleine Labels in Versalien.

```
--paper:#141517   Arbeitsfläche
--card:#1C1E21    Karten
--card-2:#212428  leicht abgesetzt
--ink:#E6E8EA     Haupttext
--ink-soft:#8D9299 Sekundärtext
--line:#2E3237    Rahmen und Trenner
--sidebar-bg:#0F1113
--danger:#E0708C
```

Weitere Akzente: Ideenboard Gold `#D9A648`, Notizzettel Altrosa `#A06F94`.
Jede Säulenfarbe hat eine gedämpfte Hintergrund-Variante für Tags und
Marken (`--privat-bg:#33262A` usw.).

**Maße heute:** Radien 10–14 px, Innenabstand in Karten 12–16 px, Trenner
1 px, kleine Labels 0,62–0,68 rem in Versalien mit `letter-spacing:.05em`.
Ein festes Spacing-Raster gibt es **nicht** – die Werte sind über die Zeit
gewachsen. Ein sauberes System dafür wäre willkommen.

Das Dunkle und die Schriften sind **nicht in Stein gemeißelt** – wenn ein
Entwurf mit hellem Papier oder anderen Schriften besser funktioniert, gern
zeigen.

## Zustände, die vorkommen

Bitte in den Entwürfen mitdenken – nicht nur den schönen Idealfall:

- **Leer** – neuer Monat ohne Belege, Jahr ohne Ziele, Kur ohne Ablauf
- **Voll** – Packliste mit 30 Punkten, 36 Module, 36 Kundenkacheln
- **Zugeklappt** – muss klar von aufgeklappt unterscheidbar sein
- **Warnung** – Frist läuft ab, Budget überschritten, „30 % hinten",
  versäumter Kur-Tag
- **Erledigt** – abgehakt, durchgestrichen, zurückgenommen

## Zwei Dinge, die bleiben müssen

**1. Verschachteln statt auflisten.** Steckt in den Daten eine Hierarchie,
muss man sie *sehen*. Also einen Block „1. Semester" mit den Modulen darin –
nicht eine flache Tabelle mit einer Spalte „Semester" daneben. Lange Listen
klappen blockweise zu, damit man am Handy nicht ewig scrollt.

**2. Farbe mit Bedeutung, sparsam.** Jede Säule hat ihre Farbe, und die zieht
sich durch: Überschrift, Häkchen, Fortschritt, Tags. Zustände (offen / läuft /
fertig, im Plan / hinten) muss man **sehen, nicht lesen**. Aber kein Schmuck
ohne Aussage – und kein farbloses Grau-in-Grau.

## Worauf es mir ankommt

- **Handy zuerst**, hochkant, Daumenbedienung. Kein reines Hover – alles muss
  antippbar sein.
- **Ruhig.** Wenig gleichzeitig sichtbar, klare Überschriften, das Wichtigste
  oben.
- **Viele Zahlen lesbar machen.** Ausgaben, Credits, Fortschritte – die Optik
  muss Zahlenkolonnen vertragen, ohne dass es nach Tabellenkalkulation aussieht.
- Sichtbare Reaktion auf jeden Klick.

## Was ich mir wünsche

**Schritt 1 – mehrere Richtungen zum Vergleichen.** Bitte nicht die ganze App
durchdesignen, sondern je Entwurf dieselben Bildschirme, damit ich sie
nebeneinander halten kann:

- die **Ausgaben-Seite** mit den drei Kacheln und den Töpfen (viele Zahlen)
- ein **verschachtelter Bereich**, Module oder Umzug (Hierarchie)
- beides **einmal am Handy und einmal am Desktop**

Dazu je Entwurf ein Satz, worin die Richtung besteht.

## Wichtig: ich will am Ende zwischen den Designs umschalten können

Ich entscheide mich **nicht** für einen Entwurf und verwerfe den Rest. Ich
möchte mehrere davon einbauen und in der App per Knopf wechseln können – so
wie andere Apps zwischen hell und dunkel umschalten, nur eben ganze Designs.

**Das ändert, wie die Entwürfe gebaut sein müssen:**

Alle Entwürfe sollen **denselben Satz Token-Namen** benutzen und sich nur in
den **Werten** unterscheiden. Also überall `--card`, `--ink`, `--radius-l`,
`--font-titel` – und in Entwurf A ist `--radius-l:14px`, in Entwurf B
`--radius-l:2px`. Dann ist der Umschalter am Ende nur ein Attribut am
`<html>`-Element:

```css
:root            { --card:#1C1E21; --radius-l:14px; }
[data-design="b"]{ --card:#FBF7F0; --radius-l:2px;  }
```

Was das bedeutet:

- Bitte **nicht** je Entwurf eine eigene Namensordnung erfinden. Ein
  gemeinsames Vokabular für alle.
- Alles, was sich zwischen den Entwürfen unterscheidet, muss ein Token sein –
  nicht nur Farben, sondern auch **Schriften, Radien, Abstände, Rahmenstärken,
  Schatten, Zeilenhöhen**. Was fest im CSS steht, lässt sich später nicht
  umschalten.
- Unterschiede im **Aufbau** (andere Reihenfolge, andere Anordnung der
  Elemente) sind schwer umschaltbar. Wenn ein Entwurf das braucht, bitte
  ausdrücklich sagen – dann entscheide ich, ob es mir das wert ist.
- Jeder Entwurf braucht einen **kurzen Namen**, der später am Knopf steht
  (z. B. „Papier", „Nacht", „Klar").

Am liebsten also: **ein System, mehrere Fassungen** – nicht vier Designs, die
nichts miteinander zu tun haben.

## Schritt 2 – die Design-Spec als Textdatei

Wenn die Richtungen stehen, brauche ich sie als Text. Bilder allein helfen mir
nicht weiter, ich muss es ja in CSS nachbauen. Gebraucht werden:

- **Ein gemeinsames Token-Verzeichnis** – jeder Name einmal erklärt (wofür er
  da ist), dann eine Spalte je Entwurf mit dem Wert. So sehe ich auf einen
  Blick, was sich zwischen den Fassungen ändert.
- **Komponentenregeln** in Worten – wie eine Karte gebaut ist, wie eine
  zuklappbare Gruppe, ein Fortschrittsbalken, ein Tag, ein Eingabefeld, ein
  Zustand (offen / läuft / fertig / Warnung). Diese Regeln gelten für **alle**
  Fassungen; nur die Token dahinter wechseln.
- **die Säulenfarben** je Fassung und wo sie auftauchen dürfen
- **was am Handy anders ist** als am Desktop

Diese Datei werfe ich dann in Claude Code, und die App wird danach umgebaut.

Also: erst das gemeinsame System festlegen, dann die Fassungen darauf,
dann setze ich um. Nicht alles auf einmal.
