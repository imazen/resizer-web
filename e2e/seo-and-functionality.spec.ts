import { test, expect } from '@playwright/test';

const BASE = 'http://localhost:3100';

test.use({ viewport: { width: 1280, height: 900 } });

test.describe('SEO essentials', () => {
	test('home page has correct title and meta description', async ({ page }) => {
		await page.goto(`${BASE}/`);
		await expect(page).toHaveTitle(/ImageResizer/);
		const desc = page.locator('meta[name="description"]');
		await expect(desc).toHaveAttribute('content', /image/i);
	});

	test('getting-started has correct title', async ({ page }) => {
		await page.goto(`${BASE}/getting-started/`);
		await expect(page).toHaveTitle(/Getting Started/);
	});

	test('canonical URL is present on pages', async ({ page }) => {
		await page.goto(`${BASE}/getting-started/`);
		const canonical = page.locator('link[rel="canonical"]');
		await expect(canonical).toHaveAttribute('href', /imageresizing\.net.*getting-started/);
	});

	test('og:title meta tag exists on home', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const og = page.locator('meta[property="og:title"]');
		await expect(og).toHaveAttribute('content', /ImageResizer/);
	});

	test('sitemap-index.xml is accessible', async ({ page }) => {
		const resp = await page.goto(`${BASE}/sitemap-index.xml`);
		expect(resp?.status()).toBe(200);
		const text = await resp?.text();
		expect(text).toContain('sitemap');
	});

	test('robots.txt is accessible and correct', async ({ page }) => {
		const resp = await page.goto(`${BASE}/robots.txt`);
		expect(resp?.status()).toBe(200);
		const text = await resp?.text();
		expect(text).toContain('imageresizing.net');
		expect(text).toContain('Sitemap');
	});
});

test.describe('i18n', () => {
	test('Spanish docs page renders with localized UI', async ({ page }) => {
		await page.goto(`${BASE}/es/getting-started/`);
		await expect(page).toHaveTitle(/Getting Started/);
		// Language selector should show Español
		const langSelect = page.locator('starlight-lang-select select').first();
		await expect(langSelect).toHaveValue(/\/es\//);
	});

	test('Japanese docs page renders with localized UI', async ({ page }) => {
		await page.goto(`${BASE}/ja/getting-started/`);
		const langSelect = page.locator('starlight-lang-select select').first();
		await expect(langSelect).toHaveValue(/\/ja\//);
	});

	test('language switcher has all 8 locales', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const langSelect = page.locator('starlight-lang-select select');
		const options = langSelect.locator('option');
		await expect(options).toHaveCount(8);
	});
});

test.describe('navigation and structure', () => {
	test('home page Get Started link works', async ({ page }) => {
		await page.goto(`${BASE}/`);
		await page.click('a:has-text("Get started")');
		await expect(page).toHaveURL(/getting-started/);
	});

	test('sidebar is present on docs pages at desktop width', async ({ page }) => {
		await page.goto(`${BASE}/getting-started/`);
		// Starlight sidebar may use aria-label="Main" but be in a collapsible container
		const sidebarContent = page.locator('.sidebar-content, [data-sl-sidebar]').first();
		await expect(sidebarContent).toBeAttached();
	});

	test('search button exists on home', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const search = page.locator('site-search button[data-open-modal]');
		await expect(search).toBeAttached();
	});

	test('theme toggle exists', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const themeSelect = page.locator('starlight-theme-select select');
		await expect(themeSelect).toBeVisible();
	});
});

test.describe('image playground', () => {
	test('playground input and preview image exist', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const input = page.locator('.pg-input');
		await expect(input).toBeVisible();
		await expect(input).toHaveValue(/width=300/);
		const img = page.locator('.pg-img');
		await expect(img).toBeAttached();
		await expect(img).toHaveAttribute('src', /z\.zr\.io/);
	});

	test('typing updates the image src', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const input = page.locator('.pg-input');
		await input.clear();
		await input.fill('height=100');
		// Wait for debounce
		await page.waitForTimeout(600);
		const img = page.locator('.pg-img');
		await expect(img).toHaveAttribute('src', /height=100/);
	});

	test('autocomplete appears when typing a parameter name', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const input = page.locator('.pg-input');
		await input.clear();
		await input.type('mo', { delay: 50 });
		const ac = page.locator('.pg-autocomplete');
		await expect(ac).toBeVisible();
		await expect(ac.locator('.ac-key')).toContainText(['mode']);
	});

	test('autocomplete completes on Tab and hides', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const input = page.locator('.pg-input');
		await input.clear();
		await input.type('mo', { delay: 50 });
		const ac = page.locator('.pg-autocomplete');
		await expect(ac).toBeVisible();
		await input.press('ArrowDown');
		await input.press('Tab');
		await expect(ac).toBeHidden();
		await expect(input).toHaveValue(/mode=/);
	});
});

test.describe('accessibility basics', () => {
	test('home page has no missing alt text on images', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const imagesWithoutAlt = page.locator('img:not([alt])');
		await expect(imagesWithoutAlt).toHaveCount(0);
	});

	test('page has a main landmark', async ({ page }) => {
		await page.goto(`${BASE}/getting-started/`);
		const main = page.locator('main');
		await expect(main).toBeVisible();
	});

	test('heading hierarchy starts with h1', async ({ page }) => {
		await page.goto(`${BASE}/getting-started/`);
		const h1 = page.locator('h1');
		await expect(h1).toHaveCount(1);
		await expect(h1).toContainText('Getting Started');
	});

	test('html lang attribute matches locale', async ({ page }) => {
		await page.goto(`${BASE}/`);
		const html = page.locator('html');
		await expect(html).toHaveAttribute('lang', 'en');

		await page.goto(`${BASE}/es/`);
		await expect(page.locator('html')).toHaveAttribute('lang', 'es');

		await page.goto(`${BASE}/ja/`);
		await expect(page.locator('html')).toHaveAttribute('lang', 'ja');
	});
});
