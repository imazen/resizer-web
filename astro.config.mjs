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
					items: [
						'getting-started',
						'docs/basics',
						'docs/best-practices',
					],
				},
				{
					label: 'Version 4',
					collapsed: false,
					items: [
						'docs/v4',
						'docs/v4/faq',
						'docs/v4/system_requirements',
						'docs/v4/configuration-all',
						{
							label: 'Installation',
							autogenerate: { directory: 'docs/v4/install' },
						},
						{
							label: 'Plugins',
							collapsed: true,
							autogenerate: { directory: 'docs/v4/plugins' },
						},
						{
							label: 'Extending',
							collapsed: true,
							autogenerate: { directory: 'docs/v4/extend' },
						},
						{
							label: 'How-To',
							autogenerate: { directory: 'docs/v4/howto' },
						},
					],
				},
				{
					label: 'Version 3',
					collapsed: true,
					items: [
						'docs/v3',
						'docs/v3/faq',
						'docs/v3/system_requirements',
						'docs/v3/configuration-all',
						{
							label: 'Installation',
							autogenerate: { directory: 'docs/v3/install' },
						},
						{
							label: 'Plugins',
							collapsed: true,
							autogenerate: { directory: 'docs/v3/plugins' },
						},
						{
							label: 'Extending',
							collapsed: true,
							autogenerate: { directory: 'docs/v3/extend' },
						},
						{
							label: 'How-To',
							autogenerate: { directory: 'docs/v3/howto' },
						},
					],
				},
				{
					label: 'Version 2',
					collapsed: true,
					autogenerate: { directory: 'docs/v2' },
				},
				{
					label: 'Releases',
					collapsed: true,
					autogenerate: { directory: 'releases' },
				},
				{
					label: 'Blog',
					collapsed: true,
					autogenerate: { directory: 'blog' },
				},
				{
					label: 'About',
					items: [
						'about-us',
						'history',
						'plugins/bundles',
					],
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
