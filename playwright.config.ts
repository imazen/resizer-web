import { defineConfig } from '@playwright/test';

export default defineConfig({
	testDir: './e2e',
	timeout: 30000,
	use: {
		headless: true,
		baseURL: 'http://localhost:3100',
	},
	webServer: {
		command: 'npx astro preview --port 3100',
		port: 3100,
		reuseExistingServer: true,
	},
});
