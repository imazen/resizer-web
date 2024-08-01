---
:aliases: []
:edit_info: support/v3/docs/install/standalone.md
:flags:
- "-sitemap"
---

# ImageResizer - Standalone Installation Tips

## Standalone Installation

Many users opt to install ImageResizer in standalone mode (on a separate application or server). 

Using ImageResizer in standalone mode and embedded mode is nearly identical - the URL API is usable from anywhere, and you can use an IIS Virtual Folder to make images accessible at the same virtual paths (for local images), or use one of the datastore plugins to connect to any file storage service. 

ImageResizer.dll offers both Client and Server APIs. The server APIs are only enabled via Web.config. You can use ImageResizer.dll as a client in one app, and as the server in another. The REST API is human-writable, so the client API is quite optional.

ImageResizer requires a .NET capable webserver like Windows+IIS, \*nix+apache+mono, or \*nix+ngix+mono. Image quality is poorer on *nix platforms due to Mono, so we suggest a separate Windows server instead. 

If you're already using Windows, you can just set up a separate Application and Application Pool in IIS. We suggest using a subdomain, so you can reassign the subdomain to a cluster or CDN as your needs grow. 

Any installation method can be used to set up a standalone server; this is the simplest installation scenario. 

[Proceed to ImageResizer for IIS Administrators](/docs/v3/install/administrators).