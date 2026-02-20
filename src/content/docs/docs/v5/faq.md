---
title: "Frequently Asked Questions"
---

## General

Should I use ImageResizer 5 or Imageflow Server?
: If your app runs on **.NET Framework 4.x** and IIS, use ImageResizer 5. If you're on **.NET 6+** or want a standalone microservice, use [Imageflow Server](https://github.com/imazen/imageflow-dotnet-server).

Is v5 a drop-in replacement for v4?
: For most deployments, yes. The URL API is almost entirely compatible. You'll need to install the Imageflow plugin and switch from DiskCache to HybridCache. See the [migration guide](/docs/v5/migration/).

Do I need to change my image URLs?
: Probably not. Most URL commands work identically. A few v4-only commands (`a.oilpainting`, `dither`, `colors`) are gone, and `a.sharpen` became `f.sharpen` with different value ranges. If you're using basic resizing, cropping, and format conversion, your URLs work as-is.

What happened to all the plugins?
: Imageflow handles what used to require SimpleFilters, PrettyGifs, AdvancedFilters, WhitespaceTrimmer, WebP, WIC, FreeImage, and FastScaling. Install `ImageResizer.Plugins.Imageflow` and you get all of that in one package.

## Image quality

Why do my images look different after upgrading?
: Imageflow processes images in linear light (not sRGB gamma space), uses better resampling algorithms, and automatically selects optimal JPEG chroma subsampling. The result is usually visibly better — sharper edges, more accurate colors, smaller file sizes. If specific images look wrong, check if they relied on GDI+ artifacts or specific AdvancedFilters behavior.

Can I force the old GDI pipeline?
: Yes — add `builder=gdi` to the URL. But the GDI pipeline doesn't benefit from Imageflow's quality and performance improvements.

## Caching

Where did DiskCache go?
: HybridCache replaces it. The key differences: the cache directory must be outside your web root, cache size is precisely limited (no more unbounded growth), and cleanup is automatic. See the [install guide](/docs/v5/install/).

My old `~/imagecache/` folder is still there. Is that a problem?
: Yes — delete it. In v4 it was a hidden folder inside your web root. With v4 removed, it may become publicly browsable.

## Compatibility

Does v5 work with my CMS?
: If your CMS runs on ASP.NET 4.x and IIS, it should work. ImageResizer 5 is still an IIS HttpModule — CMS compatibility hasn't changed from v4.

What about Azure/S3/remote images?
: AzureReader2, S3Reader2, and RemoteReader all have v5 versions. AzureReader2 now uses `Azure.Storage.Blobs` (the modern SDK); S3Reader2 uses AWS SDK v4.

Does v5 support WebP?
: Yes. Imageflow handles WebP encoding and decoding natively — no separate WebP plugin needed. Use `format=webp` in the URL.

## Troubleshooting

Imageflow native library fails to load.
: Make sure both `Imageflow.NativeRuntime.win-x86` and `Imageflow.NativeRuntime.win-x86_64` NuGet packages are installed. Check that `imageflow.dll` appears in your bin directory after building. The Visual C++ runtime may also be required on the server.

The diagnostics page shows warnings about deprecated plugins.
: Remove the deprecated plugin references from your Web.config `<plugins>` section. See the [migration guide](/docs/v5/migration/) for the full list.

Images are being processed but not cached.
: Make sure HybridCache is installed and the `cacheLocation` directory exists and is writable by the application pool identity.
