Aliases: /docs/howto/use-without-asp-net
layout: install_page

# ImageResizer - Standalone Installation or Without ASP.NET

Many users opt to install ImageResizer in standalone mode (on a separate application or server). 

Using ImageResizer in standalone mode and embedded mode is nearly identical - the URL API is usable from anywhere, and you can use an IIS Virtual Folder to make images accessible at the same virtual paths (for local imaages), or use one of the datastore plugins to connect to any file storage service.


## How to use the Image Resizer without ASP.NET

It's just as easy. If you want to use the COM interface, [read this page](/docs/howto/use-from-com). If you're using the URL API (a better choice), continue with this article.

You do have to be running a .NET capable webserver like Windows+IIS, \*nix+apache+mono, or \*nix+ngix+mono. If you are not, remember you can set up a separate port or subdomain dedicated to images, separate from your application, using IIS. Or, use a separate Windows server to handle imagery.

You can set up a standalone ImageResizer site using any installation method.