// Verify that the pinned mermaid SRI hash still matches the CDN asset.
// The diagram script fails closed when the hash drifts, so this check turns a
// silent, hard-to-review breakage into an explicit CI failure.
import { createHash } from 'node:crypto';
import { readFile } from 'node:fs/promises';

const componentUrl = new URL('../src/components/Mermaid.astro', import.meta.url);
const source = await readFile(componentUrl, 'utf8');

const src = source.match(/var SRC = '([^']+)'/)?.[1];
const integrity = source.match(/var INTEGRITY = '([^']+)'/)?.[1];

if (!src || !integrity) {
  console.error('Could not find SRC/INTEGRITY in src/components/Mermaid.astro');
  process.exit(1);
}

const response = await fetch(src, {
  redirect: 'follow',
  signal: AbortSignal.timeout(20_000),
});

if (!response.ok) {
  console.error(`Failed to fetch ${src}: ${response.status} ${response.statusText}`);
  process.exit(1);
}

const bytes = Buffer.from(await response.arrayBuffer());
const actual = `sha384-${createHash('sha384').update(bytes).digest('base64')}`;

if (actual !== integrity) {
  console.error('Mermaid SRI hash mismatch');
  console.error(`  expected: ${integrity}`);
  console.error(`  actual:   ${actual}`);
  console.error('Update INTEGRITY in src/components/Mermaid.astro to the actual hash.');
  process.exit(1);
}

console.log(`Mermaid SRI ok: ${integrity}`);
