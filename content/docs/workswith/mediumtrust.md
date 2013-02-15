
# Medium trust

ImageResizer is designed to support medium trust (and low trust). Some plugins, however, require full trust due to their nature.

## Tips

 * Insure you're using `requirePermission="false"` when registering the ImageResizer configSection in Web.config


## Essential Edition - compatible plugins

Except for PdfRenderer, all Essential Edition plugins are medium-trust compatible.
  * AutoRotate
  * ClientCache
  * CustomOverlay
  * DefaultEncoder
  * DefaultSettings
  * Diagnostics
  * DropShadow
  * FolderResizeSyntax
  * Gradient
  * IEPngFix
  * Image404
  * ImageHnadlerSyntax
  * Logging
  * MvcRoutingSHim
  * SizeLimiting
  * SpeedOrQuality
  * Presets
  * VirtualFolder

## Performance Edition - compatible plugins

  * DiskCache
  * MemCache
  * MemSourceCache
  * SourceDiskCache
  * AnimatedGifs
  
## Creative Edition - compatible plguins

* SimpleFilters
* Watermark

