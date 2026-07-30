const CACHE = 'notizblock-v2';
// Relative Pfade: unter GitHub Pages liegt die App in einem Unterordner,
// absolute Pfade wuerden dort ins Leere zeigen.
const APP_SHELL = ['./', './index.html', './manifest.json', './icon-192.png', './icon-512.png'];

self.addEventListener('install', (event) => {
  event.waitUntil(caches.open(CACHE).then((cache) => cache.addAll(APP_SHELL)));
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
  );
  self.clients.claim();
});

// Network-first: zeigt immer den neuesten Stand, wenn online; faellt offline auf den Cache zurueck.
self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET') return;
  // Cloud-Aufrufe nie zwischenspeichern - sonst kaeme ein alter Stand zurueck.
  if (event.request.url.includes('api.github.com') ||
      event.request.url.includes('gist.githubusercontent.com')) return;
  event.respondWith(
    fetch(event.request)
      .then((res) => {
        const copy = res.clone();
        caches.open(CACHE).then((cache) => cache.put(event.request, copy));
        return res;
      })
      .catch(() => caches.match(event.request))
  );
});
