import type { StarlightRouteData } from '@astrojs/starlight/route-data';

const ALL_VERSIONS = ['2', '3', '4'] as const;

/**
 * Route middleware that:
 * 1. Filters the sidebar to show only the relevant version section
 * 2. Attaches version switcher data for the PageTitle component
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
	const subPath = slug.replace(/^docs\/v\d+/, '');

	// Build version switcher links: for each version, link to the equivalent
	// page if it exists, otherwise link to the version index.
	const versionLinks = ALL_VERSIONS.map((v) => ({
		version: v,
		label: `v${v}`,
		href: `/docs/v${v}${subPath ? subPath : '/'}`,
		isCurrent: v === currentVersion,
	}));

	// Attach to route for the PageTitle component to read.
	(route as Record<string, unknown>).versionLinks = versionLinks;

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
