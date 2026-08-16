import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import App from './App';
import './styles.css';

type LaunchParams = {
  targetURL?: string;
};

type LaunchQueue = {
  setConsumer: (consumer: (launchParams: LaunchParams) => void) => void;
};

declare global {
  interface Window {
    launchQueue?: LaunchQueue;
  }
}

if (window.launchQueue?.setConsumer) {
  window.launchQueue.setConsumer((launchParams) => {
    if (!launchParams.targetURL) return;

    const target = new URL(launchParams.targetURL);
    if (target.origin !== window.location.origin) return;
    if (target.href === window.location.href) return;

    window.location.assign(target.href);
  });
}

if (import.meta.env.PROD && 'serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/sw.js').catch(() => {
      // service worker optional for MVP: app continues without cache when registration fails
    });
  });
}

createRoot(document.getElementById('root') as HTMLElement).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
