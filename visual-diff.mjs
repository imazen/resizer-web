#!/usr/bin/env node
// Visual regression test: screenshots local vs live, diffs page by page.
//
// Usage:
//   node visual-diff.mjs                    # diff all pages
//   node visual-diff.mjs /docs/v4 /blog     # diff specific pages
//   node visual-diff.mjs --list              # list all pages (no screenshots)
//
// Requires: local puma running on port 4003
// Output:   /mnt/v/output/resizer-web/visual-diff/

import { chromium } from 'playwright';
import { execSync } from 'child_process';
import { mkdirSync, writeFileSync, readFileSync, existsSync } from 'fs';
import { join } from 'path';
import { PNG } from 'pngjs';
import pixelmatch from 'pixelmatch';

const LOCAL_BASE = 'http://localhost:4003';
const LIVE_BASE = 'https://imageresizing.net';
const OUTPUT_DIR = '/mnt/v/output/resizer-web/visual-diff';
const VIEWPORT = { width: 1280, height: 900 };
const FULL_PAGE = true;
// Pixels that differ by less than this (0-255) are ignored.
// Accounts for font rendering, antialiasing, subpixel differences.
const PIXEL_THRESHOLD = 0.3;

function getAllPages() {
  const out = execSync('bundle exec ruby list-pages.rb', {
    cwd: '/home/lilith/work/resizer-web-production',
    encoding: 'utf-8',
  });
  return out.trim().split('\n').filter(p => p.startsWith('/'));
}

function sanitizePath(urlPath) {
  // /docs/v4/install -> docs-v4-install
  return urlPath.replace(/^\//, '').replace(/\//g, '-') || 'index';
}

async function screenshotPage(page, url, outputPath) {
  try {
    const resp = await page.goto(url, { waitUntil: 'networkidle', timeout: 15000 });
    if (!resp || resp.status() >= 400) {
      return { ok: false, status: resp?.status() || 0 };
    }
    // Wait a beat for any CSS transitions / lazy images
    await page.waitForTimeout(500);
    await page.screenshot({ path: outputPath, fullPage: FULL_PAGE });
    return { ok: true, status: resp.status() };
  } catch (e) {
    return { ok: false, error: e.message };
  }
}

function diffImages(imgPathA, imgPathB, diffPath) {
  const imgA = PNG.sync.read(readFileSync(imgPathA));
  const imgB = PNG.sync.read(readFileSync(imgPathB));

  // Handle different heights by padding shorter image
  const width = Math.max(imgA.width, imgB.width);
  const height = Math.max(imgA.height, imgB.height);

  function padImage(img, w, h) {
    if (img.width === w && img.height === h) return img;
    const padded = new PNG({ width: w, height: h });
    // Fill with white
    for (let i = 0; i < padded.data.length; i += 4) {
      padded.data[i] = 255;
      padded.data[i + 1] = 255;
      padded.data[i + 2] = 255;
      padded.data[i + 3] = 255;
    }
    PNG.bitblt(img, padded, 0, 0, img.width, img.height, 0, 0);
    return padded;
  }

  const a = padImage(imgA, width, height);
  const b = padImage(imgB, width, height);
  const diff = new PNG({ width, height });

  const numDiff = pixelmatch(a.data, b.data, diff.data, width, height, {
    threshold: PIXEL_THRESHOLD,
    alpha: 0.3,
    diffColorAlt: [0, 128, 255],
  });

  writeFileSync(diffPath, PNG.sync.write(diff));

  const totalPixels = width * height;
  const pctDiff = ((numDiff / totalPixels) * 100).toFixed(2);
  const heightDiff = Math.abs(imgA.height - imgB.height);

  return { numDiff, totalPixels, pctDiff, heightDiff, width, height };
}

async function main() {
  const args = process.argv.slice(2);

  if (args.includes('--list')) {
    const pages = getAllPages();
    pages.forEach(p => console.log(p));
    console.log(`\n${pages.length} pages total`);
    return;
  }

  // Get pages to test
  let pages;
  if (args.length > 0) {
    pages = args.filter(a => a.startsWith('/'));
  } else {
    pages = getAllPages();
  }

  if (pages.length === 0) {
    console.error('No pages to test. Pass paths like: /docs/v4 /blog');
    process.exit(1);
  }

  console.log(`Visual diff: ${pages.length} pages, local vs ${LIVE_BASE}`);

  // Check local server is running
  try {
    const resp = await fetch(`${LOCAL_BASE}/`);
    if (!resp.ok) throw new Error(`HTTP ${resp.status}`);
  } catch {
    console.error(`Local server not responding at ${LOCAL_BASE}`);
    console.error('Start it with: RACK_ENV=production bundle exec puma -C puma.rb --port 4003');
    process.exit(1);
  }

  // Create output directories
  const localDir = join(OUTPUT_DIR, 'local');
  const liveDir = join(OUTPUT_DIR, 'live');
  const diffDir = join(OUTPUT_DIR, 'diff');
  for (const d of [localDir, liveDir, diffDir]) {
    mkdirSync(d, { recursive: true });
  }

  const browser = await chromium.launch();
  const context = await browser.newContext({ viewport: VIEWPORT });
  const page = await context.newPage();

  const results = [];
  let done = 0;

  for (const urlPath of pages) {
    done++;
    const name = sanitizePath(urlPath);
    const prefix = `[${done}/${pages.length}]`;

    const localFile = join(localDir, `${name}.png`);
    const liveFile = join(liveDir, `${name}.png`);
    const diffFile = join(diffDir, `${name}.png`);

    // Screenshot local
    const localResult = await screenshotPage(page, `${LOCAL_BASE}${urlPath}`, localFile);
    if (!localResult.ok) {
      console.log(`${prefix} ${urlPath} - LOCAL FAILED (${localResult.status || localResult.error})`);
      results.push({ path: urlPath, status: 'local-error', detail: localResult });
      continue;
    }

    // Screenshot live
    const liveResult = await screenshotPage(page, `${LIVE_BASE}${urlPath}`, liveFile);
    if (!liveResult.ok) {
      console.log(`${prefix} ${urlPath} - LIVE FAILED (${liveResult.status || liveResult.error})`);
      results.push({ path: urlPath, status: 'live-error', detail: liveResult });
      continue;
    }

    // Diff
    const diffResult = diffImages(localFile, liveFile, diffFile);

    const tag = diffResult.pctDiff === '0.00' ? 'MATCH'
      : parseFloat(diffResult.pctDiff) < 1.0 ? 'minor'
      : parseFloat(diffResult.pctDiff) < 5.0 ? 'CHANGED'
      : 'MAJOR';

    if (tag !== 'MATCH') {
      console.log(`${prefix} ${urlPath} - ${tag} ${diffResult.pctDiff}% (${diffResult.numDiff} px${diffResult.heightDiff ? `, height diff ${diffResult.heightDiff}px` : ''})`);
    } else if (done % 25 === 0) {
      console.log(`${prefix} ${urlPath} - ok`);
    }

    results.push({
      path: urlPath,
      status: tag.toLowerCase(),
      pctDiff: diffResult.pctDiff,
      numDiff: diffResult.numDiff,
      heightDiff: diffResult.heightDiff,
    });
  }

  await browser.close();

  // Summary
  const matched = results.filter(r => r.status === 'match').length;
  const minor = results.filter(r => r.status === 'minor').length;
  const changed = results.filter(r => r.status === 'changed').length;
  const major = results.filter(r => r.status === 'major').length;
  const errors = results.filter(r => r.status.includes('error')).length;

  console.log('\n--- Summary ---');
  console.log(`Total: ${results.length} pages`);
  console.log(`  Match (0%):    ${matched}`);
  console.log(`  Minor (<1%):   ${minor}`);
  console.log(`  Changed (<5%): ${changed}`);
  console.log(`  Major (>=5%):  ${major}`);
  console.log(`  Errors:        ${errors}`);

  // Write detailed report
  const report = results
    .filter(r => r.status !== 'match')
    .sort((a, b) => parseFloat(b.pctDiff || 0) - parseFloat(a.pctDiff || 0))
    .map(r => `${r.pctDiff || 'ERR'}%\t${r.status}\t${r.path}`)
    .join('\n');

  const reportPath = join(OUTPUT_DIR, 'report.txt');
  writeFileSync(reportPath, `Visual diff report: local vs ${LIVE_BASE}\n` +
    `Date: ${new Date().toISOString()}\n` +
    `Pages: ${results.length} (${matched} match, ${minor} minor, ${changed} changed, ${major} major, ${errors} errors)\n\n` +
    `%diff\tstatus\tpath\n${report}\n`);
  console.log(`\nReport: ${reportPath}`);
  console.log(`Screenshots: ${OUTPUT_DIR}/{local,live,diff}/`);

  // Generate HTML gallery for easy visual comparison
  const htmlRows = results
    .filter(r => r.status !== 'match' && !r.status.includes('error'))
    .sort((a, b) => parseFloat(b.pctDiff) - parseFloat(a.pctDiff))
    .map(r => {
      const name = sanitizePath(r.path);
      return `<tr>
        <td><strong>${r.path}</strong><br>${r.pctDiff}% diff (${r.numDiff} px)</td>
        <td><img src="local/${name}.png" loading="lazy" style="max-width:400px"></td>
        <td><img src="live/${name}.png" loading="lazy" style="max-width:400px"></td>
        <td><img src="diff/${name}.png" loading="lazy" style="max-width:400px"></td>
      </tr>`;
    }).join('\n');

  const html = `<!DOCTYPE html>
<html><head><meta charset="utf-8"><title>Visual Diff Report</title>
<style>
  body { font-family: system-ui; margin: 20px; background: #1a1a1a; color: #eee; }
  table { border-collapse: collapse; width: 100%; }
  th, td { border: 1px solid #444; padding: 8px; vertical-align: top; }
  th { background: #333; position: sticky; top: 0; }
  img { border: 1px solid #555; }
  .summary { background: #222; padding: 15px; border-radius: 8px; margin-bottom: 20px; }
</style></head><body>
<h1>Visual Diff: Local vs Live</h1>
<div class="summary">
  <p>${results.length} pages tested &mdash;
  ${matched} match, ${minor} minor, ${changed} changed, ${major} major, ${errors} errors</p>
</div>
<table>
<tr><th>Page</th><th>Local</th><th>Live</th><th>Diff</th></tr>
${htmlRows}
</table></body></html>`;

  writeFileSync(join(OUTPUT_DIR, 'index.html'), html);
  console.log(`HTML gallery: ${OUTPUT_DIR}/index.html`);

  process.exit(major > 0 ? 1 : 0);
}

main().catch(e => { console.error(e); process.exit(2); });
