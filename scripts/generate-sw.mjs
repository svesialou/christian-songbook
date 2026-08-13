import { readdir, readFile, writeFile } from 'node:fs/promises';
import { createHash } from 'node:crypto';
import { join, relative, sep } from 'node:path';

const distDir = new URL('../dist', import.meta.url);
const swPath = new URL('../dist/sw.js', import.meta.url);

const walk = async (dir) => {
  const entries = await readdir(dir, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    const fullPath = join(dir, entry.name);
    if (entry.isDirectory()) {
      files.push(...await walk(fullPath));
      continue;
    }
    files.push(fullPath);
  }
  return files;
};

const toPublicPath = (path) => `/${relative(distDir.pathname, path).split(sep).join('/')}`;
const files = (await walk(distDir.pathname))
  .map(toPublicPath)
  .filter((path) => path !== '/sw.js')
  .sort();

const appShell = ['/', ...files];
const cacheHash = createHash('sha256')
  .update(JSON.stringify(appShell))
  .digest('hex')
  .slice(0, 12);
const sw = await readFile(swPath, 'utf8');
await writeFile(
  swPath,
  sw
    .replace('__CACHE_NAME__', `christian-songbook-${cacheHash}`)
    .replace('__APP_SHELL__', JSON.stringify(appShell, null, 2)),
  'utf8',
);
