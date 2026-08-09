# Ultimativer Notizblock – was drin ist

Bitte mehrere Design-Entwürfe für diese App. Sie ist fertig gebaut und läuft;
gesucht ist eine bessere **Optik**, nicht neue Funktionen. Ich habe **keine
festgelegte Richtung** – zeig mir gern verschiedene Handschriften.

## Was das für eine App ist

Persönliche Organisations-App für **einen einzigen Nutzer**. Kein Team, kein
Login, keine Fremden. Ersetzt viele verstreute Notizdateien. Alles auf Deutsch.

**Benutzt wird sie zu 90 % am iPhone**, hochkant, oft im Stehen und
nebenbei. Der Desktop ist Zweitgerät. Entwürfe bitte zuerst fürs Handy denken.

Technisch: eine einzige HTML-Datei, kein Build, keine Bibliotheken. Alles was
kommt, muss in handgeschriebenem CSS umsetzbar sein.

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

Das Dunkle und die Schriften sind **nicht in Stein gemeißelt** – wenn ein
Entwurf mit hellem Papier oder anderen Schriften besser funktioniert, gern
zeigen.

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

Mehrere Entwürfe in verschiedene Richtungen, damit ich vergleichen kann.
Am hilfreichsten wäre je Entwurf:

- die **Ausgaben-Seite** mit den drei Kacheln und den Töpfen
- ein **verschachtelter Bereich** (Module oder Umzug)
- die **Seitenleiste** mit den vier Säulenfarben

Danach suche ich mir eine Richtung aus und setze sie um.
