import { test } from '@playwright/test';

const BASE = 'http://localhost:3100';

const pages = [
	{ name: 'home', path: '/' },
	{ name: 'home-dark', path: '/', dark: true },
	{ name: 'getting-started', path: '/getting-started/' },
	{ name: 'getting-started-dark', path: '/getting-started/', dark: true },
	{ name: '404', path: '/nonexistent-page/' },
	{ name: 'home-mobile', path: '/', mobile: true },
	{ name: 'home-es', path: '/es/' },
	{ name: 'home-ja', path: '/ja/' },
];

for (const pg of pages) {
	test(`screenshot ${pg.name}`, async ({ page }) => {
		if (pg.dark) {
			await page.emulateMedia({ colorScheme: 'dark' });
		}
		if (pg.mobile) {
			await page.setViewportSize({ width: 390, height: 844 });
		} else {
			await page.setViewportSize({ width: 1280, height: 900 });
		}
		await page.goto(`${BASE}${pg.path}`, { waitUntil: 'networkidle' });
		await page.screenshot({
			path: `/mnt/v/output/resizer-web/screenshots/${pg.name}.png`,
			fullPage: true,
		});
	});
}
