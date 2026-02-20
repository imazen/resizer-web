---
title: "ImageResizer 5"
---

ImageResizer 5 replaces the GDI+ rendering pipeline with [Imageflow](https://github.com/imazen/imageflow), a Rust-based image processing library. The result is dramatically better image quality, smaller output files, and better concurrency — without changing your URL API.

**ImageResizer 5 is for ASP.NET 4.x on .NET Framework.** If you're on .NET 6+, use [Imageflow Server](https://github.com/imazen/imageflow-dotnet-server) instead.

## What changed

- **Imageflow replaces GDI+** as the default image processing backend. Linear light processing, modern resampling, and native-code performance.
- **HybridCache replaces DiskCache.** Precise cache size limiting, write-ahead log, and the cache directory moves outside the web root.
- **15+ plugins consolidated into one.** `ImageResizer.Plugins.Imageflow` replaces SimpleFilters, PrettyGifs, AdvancedFilters, WhitespaceTrimmer, WebP, FastScaling, WIC, FreeImage, and others.
- **Fully async pipeline.** `AsyncInterceptModule` replaces the synchronous `InterceptModule` internally (the old class name still works in Web.config for compatibility).
- **Auto-rotation is always on.** Imageflow always respects EXIF orientation; `autorotate=false` is not supported.

## Supported URL commands

Imageflow handles most of the URL API you already use:

```
width, height, w, h, maxwidth, maxheight, mode, anchor, flip, sflip,
quality, zoom, dpr, crop, cropxunits, cropyunits, format, scale,
srotate, rotate (90° increments), stretch, bgcolor,
f.sharpen, f.sharpen_when, s.invert, s.sepia, s.grayscale,
s.alpha, s.brightness, s.contrast, s.saturation,
trim.threshold, trim.percentpadding, a.balancewhite,
webp.lossless, webp.quality, jpeg.progressive, s.roundcorners,
down.colorspace, ignoreicc, watermark, preset
```

### What falls back to GDI

A few commands aren't supported by Imageflow yet. When encountered, ImageResizer falls back to the legacy GDI pipeline automatically:

- **TIFF and BMP** input files
- **Non-90° rotation** (e.g., `rotate=37`)
- **Animated GIF frame selection** (`frame=x`)
- **Border/padding/margin** CSS-era commands (`paddingWidth`, `borderWidth`, `borderColor`, `paddingColor`, etc.)
- **AdvancedFilters** commands: `a.oilpainting`, `a.sobel`, `a.threshold`, `a.canny`, `a.equalize`, `a.posterize`

### Changed commands

| v4 | v5 | Notes |
|----|-----|-------|
| `a.sharpen` | `f.sharpen` | Different algorithm; values aren't equivalent |
| `dither`, `colors` | — | PrettyGifs GIF quantization commands removed |
| `autorotate=false` | — | Always on with Imageflow |

## Licensing

The ImageResizer core and WebConfig packages remain Apache 2.0. Plugin packages (Imageflow, HybridCache, AzureReader2, S3Reader2) are AGPL 3.0 or [commercially licensed](https://imageresizing.net/licenses/).

License keys go in Web.config:

```xml
<resizer>
  <licenses>
    <license>YOUR-LICENSE-KEY</license>
  </licenses>
</resizer>
```
