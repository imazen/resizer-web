import type { StarlightRouteData } from '@astrojs/starlight/route-data';

/**
 * Route middleware that filters the sidebar to show only the relevant version
 * section when browsing versioned docs. Common sections (Start Here, Releases,
 * Blog, About) remain visible on all pages.
 */
export const onRequest: Parameters<
	typeof import('@astrojs/starlight').defineRouteMiddleware
>[0] = (context, next) => {
	const route = context.locals.starlightRoute;
	const slug = route.id;

	// Determine which version section the user is in, if any.
	const versionMatch = slug.match(/^docs\/v(\d+)\b/);
	if (!versionMatch) {
		// Not in a versioned section — show everything but collapse version groups.
		route.sidebar = route.sidebar.map((entry) => {
			if (entry.type === 'group' && /^Version \d+/.test(entry.label)) {
				return { ...entry, collapsed: true };
			}
			return entry;
		});
		return next();
	}

	const currentVersion = versionMatch[1]!;

	// Filter sidebar: keep the current version's group (expanded), common
	// sections, and version links for switching.
	route.sidebar = route.sidebar.flatMap((entry) => {
		if (entry.type !== 'group') return [entry];

		const versionGroupMatch = entry.label.match(/^Version (\d+)$/);
		if (!versionGroupMatch) {
			// Non-version group (Start Here, Releases, Blog, About) — keep collapsed.
			return [{ ...entry, collapsed: true }];
		}

		if (versionGroupMatch[1] === currentVersion) {
			// Current version — show expanded.
			return [{ ...entry, collapsed: false }];
		}

		// Other versions — collapse to a single link to that version's index.
		const indexLink = findIndexLink(entry);
		if (indexLink) {
			return [{ ...entry, entries: [indexLink], collapsed: true }];
		}
		return [{ ...entry, entries: [], collapsed: true }];
	});

	return next();
};

/** Recursively find the first link in a sidebar group (usually the version index page). */
function findIndexLink(
	entry: StarlightRouteData['sidebar'][number]
): StarlightRouteData['sidebar'][number] | undefined {
	if (entry.type === 'link') return entry;
	if (entry.type === 'group') {
		for (const child of entry.entries) {
			const found = findIndexLink(child);
			if (found) return found;
		}
	}
	return undefined;
}
