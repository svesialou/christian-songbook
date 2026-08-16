const CACHE_NAME = '__CACHE_NAME__';
const APP_SHELL = __APP_SHELL__;

const sameOrigin = (request) => new URL(request.url).origin === self.location.origin;

const cacheAsset = async (cache, request) => {
  try {
    const response = await fetch(request, { cache: 'reload' });
    if (response && response.ok) {
      await cache.put(request, response.clone());
    }
  } catch {
    // Offline-first fallback is best-effort; failed precache should not block install.
  }
};

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then(async (cache) => {
      await Promise.all(
        APP_SHELL.map((entry) => cacheAsset(cache, new Request(entry))),
      );
      await self.skipWaiting();
    }),
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(
        keys
          .filter((key) => key !== CACHE_NAME)
          .map((key) => caches.delete(key)),
      ),
    ).then(() => self.clients.claim()),
  );
});

self.addEventListener('fetch', (event) => {
  const request = event.request;

  if (request.method !== 'GET' || !sameOrigin(request)) {
    return;
  }

  if (request.url.includes('/api/')) {
    return;
  }

  const isNavigation = request.mode === 'navigate';

  if (isNavigation) {
    event.respondWith(
      fetch(request)
        .then((response) => {
          if (response && response.ok) return response;
          return caches.match('/').then((cached) => cached || response);
        })
        .catch(() =>
          caches.match('/').then((cached) => cached || new Response('Offline', { status: 503, statusText: 'Offline' })),
        ),
    );
    return;
  }

  event.respondWith(
    caches.match(request).then((cached) => {
      if (cached) return cached;

      return fetch(request)
        .then((response) => {
          if (!response || !response.ok || response.type === 'opaque') {
            return response;
          }

          const responseClone = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(request, responseClone);
          });

          return response;
        })
        .catch(() => {
          return new Response('Offline', { status: 503, statusText: 'Offline' });
        });
    }),
  );
});
