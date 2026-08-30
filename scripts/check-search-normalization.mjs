import assert from 'node:assert/strict';
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { pathToFileURL } from 'node:url';
import ts from 'typescript';

const source = readFileSync(new URL('../src/lib/search.ts', import.meta.url), 'utf8');
const compiled = ts.transpileModule(source, {
  compilerOptions: {
    module: ts.ModuleKind.ES2022,
    target: ts.ScriptTarget.ES2020,
  },
});

const tempDir = mkdtempSync(path.join(tmpdir(), 'christian-songbook-search-'));
const modulePath = path.join(tempDir, 'search.mjs');

try {
  writeFileSync(modulePath, compiled.outputText);
  const {
    buildSearchSnippet,
    buildSearchTextSegments,
    buildSongSearchIndex,
    buildSongTextSearchSource,
    matchesSearchQuery,
    normalizeSearchText,
  } = await import(pathToFileURL(modulePath).href);
  const song = {
    id: 'test-song',
    number: 1,
    title: 'Будь моим зрением',
    category: 'Поклонение',
    authors: [],
    leadSheet: '[Куплет]\nТы рядом среди штормов',
    verses: [],
  };

  assert.equal(normalizeSearchText('  Святый,   Святый!  '), 'святый святый');
  assert.equal(matchesSearchQuery('Будь моим зрением', 'БУДЬ МОИМ'), true);
  assert.equal(matchesSearchQuery('Аллилуйя, аминь', 'аллилуйя аминь'), true);
  assert.equal(matchesSearchQuery('Аллилуйя аминь', 'аллилуйя, аминь'), true);
  assert.equal(matchesSearchQuery('Ты радость и любовь моя', 'любовь радость'), true);
  assert.equal(matchesSearchQuery('Ты радость моя', 'победа'), false);
  assert.equal(matchesSearchQuery(buildSongSearchIndex(song), 'будь зрением'), true);
  assert.equal(matchesSearchQuery(buildSongSearchIndex(song), 'среди штормов'), true);
  assert.deepEqual(buildSearchTextSegments(song.title, 'БУДЬ').map((segment) => segment.isMatch), [true, false]);
  assert.equal(buildSearchSnippet(buildSongTextSearchSource(song), 'среди')?.includes('среди штормов'), true);
  assert.equal(buildSearchSnippet(buildSongTextSearchSource(song), 'будь'), null);
} finally {
  rmSync(tempDir, { recursive: true, force: true });
}
