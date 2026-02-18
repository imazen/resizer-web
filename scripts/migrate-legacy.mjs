#!/usr/bin/env node
/**
 * Migrates legacy_content markdown files to Starlight-compatible format
 * in src/content/docs/, preserving URL structure for SEO.
 */

import { readFileSync, writeFileSync, mkdirSync, readdirSync, statSync, rmSync } from 'fs';
import { join, dirname, relative, basename, extname } from 'path';

const LEGACY = 'legacy_content';
const DEST = 'src/content/docs';

function walkDir(dir) {
	const results = [];
	for (const entry of readdirSync(dir)) {
		const full = join(dir, entry);
		const stat = statSync(full);
		if (stat.isDirectory()) {
			if (['img', 'css', 'js', 'fonts', 'attachments', '_layout'].includes(entry)) continue;
			results.push(...walkDir(full));
		} else if (extname(entry) === '.md') {
			results.push(full);
		}
	}
	return results;
}

function titleFromFilename(filename) {
	return basename(filename, '.md')
		.replace(/-/g, ' ')
		.replace(/\b\w/g, c => c.toUpperCase());
}

function convertFrontmatter(raw) {
	const lines = raw.split('\n');
	const converted = [];
	for (const line of lines) {
		const match = line.match(/^:(\w+):\s*(.*)$/);
		if (match) {
			converted.push(`${match[1]}: ${match[2]}`);
		} else {
			converted.push(line);
		}
	}
	return converted.join('\n');
}

/** Check if lines at the start of a file look like bare metadata (Key: Value). */
function parseBareMetadata(content) {
	const lines = content.split('\n');
	const meta = {};
	let i = 0;
	for (; i < lines.length; i++) {
		const line = lines[i].trim();
		if (line === '') {
			// Allow blank lines between metadata
			continue;
		}
		// Key: Value pattern (key is a single word, no spaces, starting with uppercase)
		const m = line.match(/^([A-Z][A-Za-z]+):\s+(.+)$/);
		if (m) {
			meta[m[1]] = m[2].trim();
		} else {
			break;
		}
	}
	// Only treat as bare metadata if we found at least 2 key-value pairs
	if (Object.keys(meta).length >= 2) {
		return { meta, bodyStart: i };
	}
	return null;
}

function processFile(filepath) {
	let content = readFileSync(filepath, 'utf-8');
	const relPath = relative(LEGACY, filepath);

	let description = '';
	let body = content;

	// Handle Aliases: on first line (no frontmatter)
	if (content.startsWith('Aliases:')) {
		const firstNewline = content.indexOf('\n');
		body = content.slice(firstNewline + 1).trimStart();
	}
	// Handle --- frontmatter
	else if (content.startsWith('---')) {
		const endIdx = content.indexOf('---', 3);
		if (endIdx !== -1) {
			const fmRaw = content.slice(3, endIdx).trim();
			const fmConverted = convertFrontmatter(fmRaw);
			for (const line of fmConverted.split('\n')) {
				const m = line.match(/^(\w+):\s*(.+)$/);
				if (m) {
					const key = m[1].toLowerCase();
					const val = m[2].trim().replace(/^["']|["']$/g, '');
					if (key === 'tagline') description = val;
					if (key === 'summary') description = val;
				}
			}
			body = content.slice(endIdx + 3).trimStart();
		}
	}
	// Handle bare metadata (release files: Date: ..., Summary: ..., etc.)
	else {
		const bare = parseBareMetadata(content);
		if (bare) {
			if (bare.meta.Summary) description = bare.meta.Summary;
			body = content.split('\n').slice(bare.bodyStart).join('\n').trimStart();
		}
	}

	// Extract title from first # heading
	const titleMatch = body.match(/^#\s+(.+)$/m);
	let title = titleMatch ? titleMatch[1].trim() : titleFromFilename(filepath);

	// Remove the first # heading from body (Starlight renders title from frontmatter)
	body = body.replace(/^#\s+.+\n+/, '');

	// Build Starlight frontmatter
	const fm = [`title: "${title.replace(/"/g, '\\"')}"`];
	if (description) {
		// Clean up multi-line descriptions
		const cleanDesc = description.replace(/\n/g, ' ').trim();
		fm.push(`description: "${cleanDesc.replace(/"/g, '\\"')}"`);
	}

	const output = `---\n${fm.join('\n')}\n---\n\n${body}`;

	const destPath = join(DEST, relPath);
	mkdirSync(dirname(destPath), { recursive: true });
	writeFileSync(destPath, output);

	return { relPath, title };
}

// Clean destination of previously migrated content (but not getting-started.mdx or index.mdx)
const protectedFiles = new Set(['index.mdx', 'getting-started.mdx']);

// Find all legacy markdown files
const files = walkDir(LEGACY);
console.log(`Found ${files.length} markdown files to migrate\n`);

const migrated = [];
for (const f of files) {
	try {
		const result = processFile(f);
		migrated.push(result);
		console.log(`  ✓ ${result.relPath}`);
	} catch (err) {
		console.error(`  ✗ ${relative(LEGACY, f)}: ${err.message}`);
	}
}

console.log(`\nMigrated ${migrated.length}/${files.length} files`);
