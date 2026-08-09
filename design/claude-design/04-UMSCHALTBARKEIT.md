# Ziel: mehrere Designs, umschaltbar per Knopf

Ich will am Ende **nicht ein Design**, sondern mehrere – und in der App
zwischen ihnen wechseln können, wie andere Apps zwischen hell und dunkel.

Das geht in reinem CSS: ein Attribut am `<html>`-Element, darunter je Fassung
ein anderer Satz Werte.

```css
:root                  { --card:#1C1E21; --radius-l:14px; --font-titel:'Fraunces',serif; }
[data-design="papier"] { --card:#FBF7F0; --radius-l:2px;  --font-titel:'Spectral',serif; }
[data-design="klar"]   { --card:#FFFFFF; --radius-l:8px;  --font-titel:'Inter',sans-serif; }
```

Der Knopf setzt nur `document.documentElement.dataset.design = 'papier'`.
Kein Neuladen, kein zweites Stylesheet.

**Damit das funktioniert, muss alles Unterscheidende ein Token sein.**

## Wie es heute aussieht (der Grund für diese Datei)

Ich habe die bestehende `index.html` durchgezählt. 1.712 Zeilen CSS:

| | Anzahl | Problem |
|---|---|---|
| Farben in Variablen | 21 | ✅ die lassen sich umschalten |
| **feste Hex-Farben direkt im CSS** | **64** (30 verschiedene) | ❌ bleiben beim Umschalten hängen |
| **feste `rgba()`-Werte** | **99** | ❌ dito – meist Schatten und Schleier |
| **`border-radius` fest** | **8 verschiedene Werte** | ❌ 7px, 10px, 8px, 20px, 6px, 5px, 9px, 50% |
| Abstände | überall fest | ❌ kein Raster |
| Schriftgrößen | überall fest | ❌ keine Skala |

Heißt: Die App ist **noch nicht** umschaltbar. Der Umbau dahin ist Teil der
Arbeit, und ich mache ihn in Claude Code – aber ich brauche von euch das
System, nach dem ich ihn mache.

## Was ich deshalb von euch brauche

**1. Ein Token-Verzeichnis, das für alle Fassungen gilt.**
Jeder Name einmal erklärt, wofür er da ist – dann eine Spalte je Fassung mit
dem Wert. Etwa so:

| Token | Wofür | Nacht | Papier | Klar |
|---|---|---|---|---|
| `--card` | Kartenfläche | `#1C1E21` | `#FBF7F0` | `#FFFFFF` |
| `--radius-l` | große Karten | `14px` | `2px` | `8px` |
| `--radius-s` | Tags, Knöpfe | `7px` | `0` | `4px` |
| … | | | | |

**2. Vollständig genug, dass nichts fest bleiben muss.** Bitte auch Token für:

- **Schatten** – heute 99 feste `rgba()`, meist Schatten und Schleier
- **Radien** – wie viele Stufen braucht ihr? Zwei? Drei?
- **Abstände** – eine Skala (z. B. 4 / 8 / 12 / 16 / 24 / 32)
- **Schriftgrößen** – eine Skala, dazu welche Schrift wo
- **Rahmenstärken** – 1 px überall, oder je Fassung anders?
- **Zeilenhöhen**
- **Übergänge** – Dauer und Kurve

Was ihr nicht als Token vorgebt, bleibt bei mir fest im CSS stehen und lässt
sich später nicht umschalten.

**3. Die Säulenfarben je Fassung.** Vier Säulen (Privat, Business, Uni, Sport)
plus Ideenboard, Notizzettel und eine Warnfarbe – je Fassung ein Satz, der
zusammenpasst. Dazu die gedämpften Hintergrund-Varianten für Tags.

**4. Ein kurzer Name je Fassung.** Der steht später am Umschalt-Knopf. Ein
Wort, das trifft: „Papier", „Nacht", „Klar".

## Was schwierig wird

Unterschiede in der **Anordnung** – andere Reihenfolge der Elemente, andere
Struktur – lassen sich nicht per Token umschalten, dafür bräuchte es zwei
Fassungen des HTML. Wenn eine Richtung das unbedingt braucht, sagt es
ausdrücklich dazu; dann entscheide ich, ob mir das die Mühe wert ist.

Unterschiede in **Fläche, Farbe, Form, Schrift, Dichte** sind dagegen völlig
frei – das deckt sehr viel ab. Eine luftige helle Papier-Fassung und eine
dichte dunkle können denselben HTML-Aufbau haben.

## Wie viele Fassungen

Drei oder vier. Sie sollten **deutlich verschieden** wirken – sonst lohnt der
Umschalter nicht. Aber sie sollten aus **einem System** kommen: gleiche
Namen, gleiche Regeln, andere Werte.

## Und jede Fassung braucht hell und dunkel

Jedes Design soll es **zweimal** geben: eine helle und eine dunkle Variante.
Bei drei Designs also sechs Farbsätze.

Wichtig: Das ist **keine bloße Umkehrung**. Eine helle Fassung braucht andere
Kontraste, oft andere Sättigung bei den Säulenfarben (auf Weiß wirken sie
schnell grell, auf Dunkel schnell matt), manchmal auch andere Schatten – auf
Hell trägt ein weicher Schatten, auf Dunkel eher eine hellere Kante.

Die **Struktur bleibt dieselbe**: gleiche Radien, gleiche Abstände, gleiche
Schriften, gleiche Komponentenregeln. Nur die Farb-Token wechseln. Ein Design
ist also: eine Form + zwei Farbsätze.

Technisch werden es zwei Attribute:

```css
:root                                { /* Struktur-Token, für alle gleich */ }

[data-design="nacht"][data-mode="dunkel"] { --paper:#141517; --card:#1C1E21; --ink:#E6E8EA; }
[data-design="nacht"][data-mode="hell"]   { --paper:#F4F2EE; --card:#FFFFFF; --ink:#1A1C1E; }

[data-design="papier"][data-mode="dunkel"]{ … }
[data-design="papier"][data-mode="hell"]  { … }
```

**Im Token-Verzeichnis bitte je Fassung zwei Spalten** – hell und dunkel.
Struktur-Token (Radien, Abstände, Schriften) stehen nur einmal, weil sie in
beiden Modi gleich sind. So sehe ich sofort, was wirklich vom Modus abhängt.

Wenn eine Richtung **nur** hell oder **nur** dunkel funktioniert, sagt es
lieber, statt eine schlechte Gegenvariante zu bauen. Dann ist es eben eine
Fassung mit einem Modus.
