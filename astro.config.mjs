// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightLinksValidator from 'starlight-links-validator';

export const locales = {
	root: { label: 'English', lang: 'en' },
	es: { label: 'Español', lang: 'es' },
	'zh-cn': { label: '简体中文', lang: 'zh-CN' },
	ja: { label: '日本語', lang: 'ja' },
	de: { label: 'Deutsch', lang: 'de' },
	it: { label: 'Italiano', lang: 'it' },
	fr: { label: 'Français', lang: 'fr' },
	sv: { label: 'Svenska', lang: 'sv' },
};

const site = 'https://imageresizing.net/';

export default defineConfig({
	site,
	trailingSlash: 'always',
	integrations: [
		starlight({
			title: 'ImageResizer',
			lastUpdated: true,
			editLink: {
				baseUrl: 'https://github.com/imazen/resizer-web/edit/starlight/',
			},
			social: [
				{ icon: 'github', label: 'GitHub', href: 'https://github.com/imazen' },
			],
			locales,
			sidebar: [
				{
					label: 'Start Here',
					items: ['getting-started'],
				},
			],
			plugins: process.env.CHECK_LINKS
				? [
						starlightLinksValidator({
							errorOnFallbackPages: false,
							errorOnInconsistentLocale: true,
						}),
					]
				: [],
		}),
	],
});
