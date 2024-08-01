import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';
import starlightLinksValidator from 'starlight-links-validator';
import starlightVersions from 'starlight-versions';
import starlightBlog from 'starlight-blog';
import starlightUtils from "@lorenzo_lewis/starlight-utils";
import redirects from './src/redirects.json';
import sitemap from "@astrojs/sitemap";
import redirectFrom from "astro-redirect-from";

// https://astro.build/config
export default defineConfig({
  site: 'https://imageresizing.net',
  redirects: redirects,
  integrations: [starlight({
    editLink: {
      baseUrl: 'https://github.com/imazen/resizer-web/edit/astro/'
    },
    plugins: [starlightBlog(), starlightUtils({
      navLinks: {
        leading: {
          useSidebarLabelled: 'leadingNavLinks'
        }
      }
    }), starlightBlog({
      authors: {
        lilith: {
          name: 'Lilith',
          title: 'Lead engineer & owner',
          picture: '/lilith.jpg',
          // Images in the `public` directory are supported.
          url: 'https://github.com/lilith'
        }
      }
    }), starlightLinksValidator()
    // starlightVersions({
    //   versions: [{ slug: '1-0', label: '1' }],
    // }),
    ],
    defaultLocale: 'root',
    locales: {
      root: {
        label: 'English',
        lang: 'en' // lang is required for root locales
      },
      'es': {
        label: 'Español',
        lang: 'es'
      }
    },
    title: 'ImageResizer',
    logo: {
      src: './src/assets/imageresizer_400_00aec4.png',
      replacesTitle: true
    },
    social: {
      github: 'https://github.com/imazen/resizer'
    },
    sidebar: [{
      label: 'Guides',
      items: [
      // Each item here is one entry in the navigation menu.
      {
        label: 'Example Guide',
        slug: 'guides/example'
      }]
    }, {
      label: 'Reference',
      autogenerate: {
        directory: 'reference'
      }
    }, {
      label: 'leadingNavLinks',
      items: [{
        label: 'Start',
        link: '/start'
      }, {
        label: 'Docs',
        link: '/docs'
      }, {
        label: 'Support',
        link: '/support'
      }, {
        label: 'Pricing',
        link: '/pricing'
      }]
    }]
  }), sitemap(), redirectFrom({
	contentDir: './src/content/docs'
  })]
});