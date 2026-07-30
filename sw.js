// Version bei jeder Aenderung hochzaehlen. Der Name steckt im Cache-Schluessel:
// aendert er sich, wirft "activate" alle alten Caches weg und das Geraet holt
// alles neu. Ohne das haelt vor allem Safari am iPhone die alte Fassung fest,
// egal wie oft man neu laedt.
const VERSION = 'v5-2026-07-31-iconnamen';
const CACHE = 'notizblock-' + VERSION;

// Relative Pfade: unter GitHub Pages liegt die App in einem Unterordner,
// absolute Pfade wuerden dort ins Leere zeigen.
const APP_SHELL = ['./', './index.html', './manifest.json',
                   './app-icon-180-v2.png', './app-icon-192-v2.png', './app-icon-512-v2.png'];

self.addEventListener('install', (event) => {
  event.waitUntil(caches.open(CACHE).then((cache) => cache.addAll(APP_SHELL)));
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

// Erlaubt der Seite, ein Update sofort zu uebernehmen statt beim naechsten Start.
self.addEventListener('message', (event) => {
  if (event.data === 'skipWaiting') self.skipWaiting();
});

// Network-first mit Zeitgrenze: bleibt das Netz drei Sekunden stumm, kommt der
// Cache zum Zug. Ohne die Grenze haengt die App bei schlechtem Empfang, mit
// einem reinen Cache-Fallback wuerde sie dagegen alte Staende zeigen.
self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET') return;
  // Cloud-Aufrufe nie zwischenspeichern - sonst kaeme ein alter Stand zurueck.
  if (event.request.url.includes('api.github.com') ||
      event.request.url.includes('gist.githubusercontent.com')) return;

  event.respondWith(
    Promise.race([
      fetch(event.request).then((res) => {
        if (res && res.ok) {
          const copy = res.clone();
          caches.open(CACHE).then((cache) => cache.put(event.request, copy));
        }
        return res;
      }),
      new Promise((_, ab) => setTimeout(() => ab(new Error('zu langsam')), 3000))
    ]).catch(() => caches.match(event.request).then((c) => c || fetch(event.request)))
  );
});
