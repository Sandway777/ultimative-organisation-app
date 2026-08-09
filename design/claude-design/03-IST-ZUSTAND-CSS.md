# Ist-Zustand: was heute im CSS steht

Damit ihr wisst, worauf ihr aufsetzt. Das ist **kein System**, sondern
gewachsen – ein sauberes Token-Set wäre der eigentliche Gewinn.

## Schriften (Google Fonts, das einzige Externe)

```
Fraunces        opsz 9..144, Gewichte 500 / 600 / 700   → Überschriften
IBM Plex Sans   400 / 500 / 600                          → Fließtext, Knöpfe
IBM Plex Mono   500                                      → Labels, Zahlen, Beträge
```

Mono wird für **alle Beträge und Kennzahlen** benutzt, damit Zahlenkolonnen
untereinander stehen. Kleine Labels laufen in Versalien mit
`letter-spacing:.05em`, Größe 0,62–0,68 rem.

## Farben, wie sie heute definiert sind

```css
:root{
  /* Flächen – warme, nicht blaustichige Grautöne */
  --paper:#141517;       /* Arbeitsfläche */
  --card:#1C1E21;        /* Karten, aktive Einträge */
  --card-2:#212428;      /* leicht abgesetzt */
  --field:#191B1E;       /* Eingabefelder */
  --sidebar-bg:#0F1113;
  --sidebar-line:rgba(255,255,255,.07);

  /* Text */
  --ink:#E6E8EA;         /* Haupttext */
  --ink-soft:#8D9299;    /* Sekundärtext */

  /* Linien */
  --line:#2E3237;        /* Rahmen, Trenner */
  --line-soft:#26292E;   /* feine Trenner in Listen */

  /* Die vier Säulen + Warnfarbe */
  --privat:#E08060;      --privat-bg:#33262A;
  --business:#4FA8A2;    --business-bg:#1D3335;
  --uni:#8494CC;         --uni-bg:#252A3B;
  --sport:#7FB169;       --sport-bg:#26312A;
  --danger:#E0708C;

  /* Hauptbereiche außerhalb der Säulen */
  --idea:#D9A648;        /* Ideenboard */
  --daily:#A06F94;       /* Notizzettel */
}
```

Die `-bg`-Varianten sind gedämpfte Hintergründe für Tags, Marken und
hervorgehobene Karten in der jeweiligen Säulenfarbe.

## Maße, wie sie gewachsen sind

| Was | Werte heute |
|---|---|
| Eckradien | 10–14 px (Karten), 999 px (Tags, Pillen) |
| Innenabstand Karten | 12–16 px |
| Abstand zwischen Karten | 10–14 px |
| Trennlinien | 1 px |
| Seitenleiste | 250 px breit, am Handy ausklappbar |
| Kleine Labels | 0,62–0,68 rem, Versalien, `letter-spacing:.05em` |

**Ein festes Spacing-Raster gibt es nicht.** Genauso wenig ein System für
Schriftgrößen oder Schatten. Wenn ihr eins vorgebt, halte ich mich daran.

## Was technisch geht

- CSS Custom Properties, Flexbox, Grid, `@media`, `@supports`
- `env(safe-area-inset-*)` wird schon genutzt (iPhone-Vollbild)
- `100dvh` statt `100vh` – wegen der ein- und ausfahrenden Adressleiste
- Übergänge und Transformationen, gern

## Was nicht geht

- keine Utility-Klassen (kein Tailwind)
- keine Komponentenbibliothek (kein shadcn, kein Material)
- keine Icon-Bibliothek – **Emoji sind die Icons**
- keine externen Bilder oder Schriftdateien außer Google Fonts
- kein Build-Schritt, also auch kein Sass, kein PostCSS
