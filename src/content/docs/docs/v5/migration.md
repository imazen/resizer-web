---
title: "Migrating from v4 to v5"
---

ImageResizer 5 is a drop-in upgrade for most v4 deployments. The URL API is largely unchanged — the big difference is under the hood: Imageflow replaces GDI+ for image processing.

## Step-by-step

1. **Retarget to .NET Framework 4.8** (up from 4.5 in v4).

2. **Install the new packages:**

    ```powershell
    PM> Install-Package ImageResizer.Plugins.Imageflow -pre
    PM> Install-Package Imageflow.NativeRuntime.win-x86 -pre
    PM> Install-Package Imageflow.NativeRuntime.win-x86_64 -pre
    PM> Install-Package ImageResizer.Plugins.HybridCache
    ```

3. **Uninstall deprecated plugin packages.** All `ImageResizer.*` packages must have the same version number. Remove any package that doesn't have a v5 release:

    - `ImageResizer.Plugins.DiskCache`
    - `ImageResizer.Plugins.PrettyGifs`
    - `ImageResizer.Plugins.AnimatedGifs`
    - `ImageResizer.Plugins.SimpleFilters`
    - `ImageResizer.Plugins.AdvancedFilters`
    - `ImageResizer.Plugins.WhitespaceTrimmer`
    - `ImageResizer.Plugins.WebP`
    - `ImageResizer.Plugins.Wic*`
    - `ImageResizer.Plugins.FreeImage*`
    - `ImageResizer.Plugins.FastScaling*`
    - `ImageResizer.Plugins.TinyCache`
    - `ImageResizer.Plugins.Watermark` (the legacy watermark plugin)

4. **Update Web.config plugins.** Remove the corresponding `<add name="..." />` lines for every uninstalled plugin. Add the new ones:

    ```xml
    <plugins>
      <add name="Imageflow" />
      <add name="HybridCache" />
      <!-- Keep AzureReader2, S3Reader2, RemoteReader if used -->
    </plugins>
    ```

5. **Replace DiskCache with HybridCache.** Remove any `<diskCache ... />` element and add:

    ```xml
    <hybridCache cacheLocation="C:\imageresizercache\"
                 cacheSizeMb="1000" />
    ```

    **Delete the old `~/imagecache/` folder.** In v4 it was inside your web root. If left in place, it becomes publicly browsable.

6. **Check `/resizer.debug`** for remaining configuration issues.

## Behavioral changes to watch for

### Auto-rotation is always on

Imageflow always applies EXIF orientation correction. If your v4 site used `autorotate=false` or relied on images staying in their original EXIF orientation, those images will now render rotated correctly. This is usually what you want, but it can change the visible dimensions of some images.

### Sharpening changed

`a.sharpen` (AdvancedFilters) doesn't map to `f.sharpen` (Imageflow). They use different algorithms with different value ranges. If you relied on specific `a.sharpen` values, test with `f.sharpen` and adjust.

### GIF quantization commands gone

`dither`, `colors`, and `preservePalette` from PrettyGifs are not supported by Imageflow. GIF encoding uses Imageflow's built-in quantizer, which generally produces better results anyway.

### Some commands trigger GDI fallback

TIFF/BMP input, non-90° rotation, animated GIF frame selection, and border/padding/margin commands cause ImageResizer to fall back to the legacy GDI pipeline. This is transparent — your URLs still work — but you won't get Imageflow's quality and performance for those requests. See the [full list](/docs/v5/#what-falls-back-to-gdi).

### SizeLimits don't apply to Imageflow

The `<sizelimits>` configuration only affects the GDI pipeline. Imageflow has its own internal limits.

## What about Imageflow Server?

If you're already on .NET 6+ (or migrating), skip ImageResizer entirely and use [Imageflow Server](https://github.com/imazen/imageflow-dotnet-server). It's a standalone middleware/microservice with the same URL API, designed for modern .NET.

ImageResizer 5 exists specifically for **.NET Framework 4.x** projects that can't migrate yet.
