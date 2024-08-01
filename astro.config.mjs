import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightLinksValidator from 'starlight-links-validator'
import starlightVersions from 'starlight-versions'
import starlightBlog from 'starlight-blog'

// https://astro.build/config
export default defineConfig({
	site: 'https://imageresizing.net',
	integrations: [
		starlight({
			plugins: [
				starlightBlog(),
				starlightLinksValidator(),
				// starlightVersions({
				//   versions: [{ slug: '1-0', label: '1' }],
				// }),
			  ],
			  defaultLocale: 'root', 
			  locales: {
				root: {
				  label: 'English',
				  lang: 'en', // lang is required for root locales
				},
				'es': {
					label: 'Español',
					lang: 'es',
				},
			},
			title: 'ImageResizer',
			logo: {
				src: './src/assets/imageresizer_400_00aec4.png',
				replacesTitle: true,
			  },
			social: {
				github: 'https://github.com/imazen/resizer',
			},
			sidebar: [
				{
					label: 'Guides',
					items: [
						// Each item here is one entry in the navigation menu.
						{ label: 'Example Guide', slug: 'guides/example' },
					],
				},
				{
					label: 'Reference',
					autogenerate: { directory: 'reference' },
				},
			],
		}),
	],
});
