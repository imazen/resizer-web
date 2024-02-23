Date: December 7, 2011
FullFile: http://downloads.imageresizing.net/Resizer3-1-alpha-2-full-Dec-7-2011.zip
MinFile: http://downloads.imageresizing.net/Resizer3-1-alpha-2-min-Dec-7-2011.zip
Summary: 5 new free plugins, 6 new bundle plugins, 5 rewritten plugins, and innumerable bug fixes
ShortVersion: 3.1.2

# Resizer 3.1 alpha 2 - Dec 7 2011

This is the first public release of 3.1. It's a major milestone, involving over 229 commits, introducing 11 new plugins, and bringing majorly cool features or overhauls to 10 existing plugins. Please contact support@imageresizing.net with any bugs or suggestions about this release.

In fact, to encourage everyone to actively look for bugs and report them, I'm **currently offering a $5-$50 bounty per bug you find and report before anyone else**! Most bug reports are firmly in the $5 category, but a security hole or memory leak could net you $50 for the one bug. Payments sent via PayPal. All class libraries whose names start with ImageResizer are eligible. Email bug reports to `support@imageresizing.net`.

### Changes since [3.0.13 (Oct 12)](/releases/3-0-13)

As nearly all plugins were modified in this release, please refer to the individual plugin-specific sections below to see how you might be affected.

Version 3.1 adds the following *free* plugins:

* [SpeedOrQuality](/plugins/speedorquality) - Sacrifice quality for 10-40% more speed. Still in alpha.
* [DefaultSettings](/plugins/defaultsettings) - Decide which ScaleMode setting should be the default, and for which situations. Many people find the &scale=downscaleonly default value frustrating - now they can change it.
* [Presets](/plugins/presets) - Create preset setting groups in Web.config and use them from the URL. 
* [AutoRotate](/plugins/autorotate) - Automatically rotate the image based on the camera's gravity sensor data, with `&autorotate=true`
* [Logging](/plugins/logging) - NLog wrapper to allow optional logging. Logging only implemented for DiskCache plugin at the moment.

The Design bundle gets these new plugins. If you've already bought the Design bundle, you get these for free!

* [WicEncoder](/plugins/wic) - Encode jpegs with adjustable quality and subsampling settings. Encode GIFs and 8-bit PNGs with adjustable palette size and bit depth.
* [WicDecoder](/plugins/wic) - Decode images using any WIC-enabled codec installed on the computer
* [WicBuilder](/plugins/wic) - Provides a completely alternate pipeline, which supports most basic resize/crop/pad operations. 2-4x faster than the default pipeline. Enable on a per-request basis using `builder=wic`.
* [FreeImageResizer](/plugins/freeimage) - Adds support for Lanczos3 and CatmullRom scaling algorithms: &fi.scale=bicubic|bilinear|box|bspline|catmullrom|lanczos command

The Extras bundle is introduced, and starts out with the following 2 plugins

* [BatchZipper](/plugins/batchzipper) - Asynchronously generated .zip archives of files and resized images. Great for providing customized downloads to customers.
* [PsdComposer](/plugins/psdcomposer) - Dynamically edit and render PSD files - turn layers on and off, edit text layer contents, and apply certain effects.


### FriendlyUrls reminder

If you are still using the FriendlyUrls plugin, [you need to rename it in Web.config - it has been part of the core for 3 releases now as FolderResizeSyntax](/plugins/friendlyurls), and is no longer included as a separate dll.

## Cool new features in the ImageResizer.dll core project

* `mode=max|pad|crop|stretch|carve` provides a single command to control how aspect ratio changes are handled. It doesn't introduce new features, but is easier to remember than `maxwidth` vs `width`, `crop=auto`, `stretch=fill`, and `carve=true`. Although, as always, everything is fully backwards-compatible. Example: `?maxwith=10&maxheight=10` is equivalent to `?width=10&height=10&mode=max`. 
* Control how images are cropped or padded (when the aspect ratio is being modified) using the `anchor` command:  &anchor=topleft|bottomright|middlecenter... 
* You can now rotate the source image in 90 degree intervals using `sRotate`. This is useful if you'd like to rotate prior to doing a manual crop.
* The new `ImageBuilder.Build(Job job)` overload allows you more control over how streams are handled - you can even choose to dispose the destination stream when the job is complete, or restore the position of the original stream.
* You can now specify individual left, top, right, and bottom edge widths for margin, borderWidth, and paddingWidth values. I.e, `?margin=10,20,10,20&borderWidth=50,10,50,10&borderColor=blue`

## Boring new features in ImageResizer.dll 

* Set the print density of an output image with `&dpi=96|300|600`. No browsers support this, but a few printers do. Default is 96.  See [this article on why the DPI (resolution) setting is worthless](http://apptools.com/examples/dpi.php).
* Added performance optimization for resizing non-transparent to non-transparent images with no padding.
* Diagnostics page has dozens of new checks to ensure you've configured everything for optimal performance.
* &scale=down|up|canvas are newly supported shortcuts for downscaleonly,  upscaleonly, and upscalecanvas
* You can now perform a source flip on an image using `sFlip` instead of `sourceFlip`, although the longer name is also supported.
* ResizeSetting now accepts semicolon-delimited pairs in its constructor: `new ResizeSettings("width=100;height=100")` Yay for readability!  
* You can now both perform a manual crop, then autocrop the result to a specified with and height. I.e. `image.jpg?crop=400,10,-10,-10&width=100&height=100&mode=crop`

For a list of API changes that affect plugin developers, see the bottom of the page.

## The last surviving GDI+ artifact, dead

After 3 years of wrestling with the last GDI+ border bug (the 50% transparency white 1px border on resized images), it has finally been killed! 

With the introduction of the WIC and FreeImage pipelines, I finally tried the border test on them as well, and guess what... All three had the border artifact! Knowing that to be impossible, I checked the original photos, and it was there as well. Sometime in 2008, those photos were resized with V2.0, and acquired the border artifact. The last remaining GDI border bug was actually solved in V2.6, but since the border was already in the original images, it only showed up as a 25% reduction in brightness. 

Chagrin would be the word. How could I ever fix a non-existent bug? I sure spent a lot of time trying...

## [DiskCache](/plugins/diskcache)

* Greatly reduced CPU usage when autoClean="true" (for certain rare situations).
* Added beta support for async writes. Enable by setting `asyncWrites=true` on the `<diskcache>` element. The async buffer size defaults to a maximum of 10MB, but can be changed with the `asyncBufferSize` setting (which is in bytes). Async writes can greatly improve performance if you have a slow, overloaded, or high-latency hard disk/SAN.
* Fixed bug in LockProvider where a failed image resizing request would cause the lock provider to fail to remove the lock object for the request from the dictionary. If you have millions of failed requests during a single app pool cycle, this could cause reduced performance an higher RAM usage.
* Added support for cooperative cache cleanup, using a mutex to prevent more than one process from cleaning the same folder at the same time. Should help support extended overlapped recycles and web garden scenarios.
* Added support for recovering from another process writing to the same cache file at the same time. Only works in `hashModifiedDate=true` mode.
* Added optional logging support so you can see exactly what is happening with the cache in real-time
* Handles insufficient permissions more gracefully, explains issue on the diagnostics page

## [PrettyGifs](/plugins/prettygifs)

* Fixed bug where an OverflowException would occur when generating a GIF or 8-bit PNG file on a 64-bit server, but only when over 4GB of ram was in use.


## [Watermark](/plugins/watermark) plugin

We admit, the original Watermark plugin was sad. 

The new one isn't. Here are a few of the new features

* Fully XML configurable. No more Global.asax.cs junk.
* Full-featured text layers
* Flexible image layers
* Layer groups 
* Reference multiple groups or layers from the URL
* Flexible layer layout system to shame even WPF. Anything is possible, and it's intuitive. 
* Overlay AND background layer support.
* Image layers can use any virtual or physical file - even a generated gradient from the Gradient plugin! 
* Image layers can be pre-processed with the same pipeline... they can even have their own watermarks inside. 
* Text layers support both fixed and scale-to-fit font sizes, configurable font typefaces, and font styles.
* Text layers support text outline and glow effects (even combined), all colors are configurable, and the text can be rotated to any angle.

Oh, and guess what - it's fully backwards compatible. You can take advantage of the new features while still supporting your old code and URLs. You can migrate your old code to the new XML syntax at your leisure. Your URLs don't ever need to be changed.


## [SimpleFilters](/plugins/simplefilters)

* Added support for combining multiple filters
* Added adjustable grayscale conversion
* Added brightness, contrast, and saturation adjustment settings ("s.brightness", "s.contrast", "s.saturation")
* Fixed broken sepia filter
* Added invert filter


## [SizeLimiting](/plugins/sizelimiting)

* Size limits are now inclusive instead of exclusive, to match normal user expectation

## [VirtualFolder](/plugins/virtualfolder)

* Now can fall back to IVirtualImageProvider
* Handles insufficient permissions more gracefully, explains issue on the diagnostics page


## [FreeImage](/plugins/freeimage)

### Breaking changes

* FreeImageEncoder no longer acts as the default encoder. To enable, use `encoder=freeimage` in the request URL.
* FreeImageBuilder is no longer activated via &freeimage=true. To activate, use `builder=freeimage`.
* FreeImageDecoder can be requested as the primary decoder with `decoder=freeimage` instead of `freeimage=true`. As always, it is a default fallback decoder if the other decoders can't handle the stream.

### The good news

* Got a customized version of FreeImage based on libjpeg-turbo. 2-4x faster jpeg encoding and decoding!
* Improved overall performance of non freeimage-related requests when a FreeImage plugin was installed by reordering some statements.
* Now works with http:// source URLs when RemoteReader is installed.
* Now works with COM clients such as ASP
* FreeImageBuilder now supports all the standard 'source' and 'dest' formats (except Bitmap), plus all the standard parameters.
* Added FreeImageResizer plugin, with &fi.scale=bicubic|bilinear|box|bspline|catmullrom|lanczos command. Uses GDI resizing afterwards for cases where stretching or rotation occurs. Useful if you need a high-quality upscaling algorithm or something a bit more specialized than GDI's 2-pass bicubic algorithm.
* FreeImageBuilder longer rescales image unless needed.
* FreeImageEncoder now supports `quality=10|25|50|75|100`, `subsampling=444|422|420|411`, and `progressive=true` for adjusting jpeg encoding!
* FreeImageDecoder and FreeImageBuilder now support &autorotate=true

## [CloudFront](/plugins/cloudfront)

* Now supports (optional) automatic redirection - change a setting to redirect all image traffic through a CloudFront distribution. `<cloudfront redirectThrough="http://cdn.mysite.com/" redirectPermanent="false /">`
* Fixed bug - now handles folders with a '.' in them properly, i.e, /folder.ext/file.ext;width=100 (ASP.NET's PathInfo madness...).
* Now merges query strings during PreAuthorizeEvent instead of at RewriteDefaults, which should be more expected. 
* Now plays nice with other PreRewritePath and ModifiedQueryString stuff that may be registered.

## [SqlReader](/plugins/sqlreader)

* Now completely configurable via XML
* Added RequireImageExtension, CacheUnmodifiedFiles, and UntrustedData settings
* 
Also added complete XML configurability.

* Can now fallback to IVirtualImageProvider if security restrictions prevent it registering as a VirtualPathProvider. Or, you can manually request it only register as an IVirtualPathProvider by setting `vpp="false"`. IVirtualImageProviders can only provide files to the image resizer.
* Fixed infinite loop triggered by handling the BeforeAccess event (stupid typo)
* SqlReader: Added Settings property to allow easy access to configuration.
* Renamed methods to indicate they are ready for public consumption.
.authorize -> .FireAuthorizeEvent
.getStream -> .GetStream
.getIdParameter -> .CreateIdParameter
.rowExists -> .RowExists
.getDateModifiedUtc -> GetDateModifiedUtc
.getIdFromPath -> ParseIdFromVirtualPath

## [AzureReader](/plugins/azurereader)

* Can now fallback to IVirtualImageProvider if security restrictions prevent it registering as a VirtualPathProvider. Or, you can manually request it only register as an IVirtualPathProvider by setting `vpp="false"`. IVirtualImageProviders can only provide files to the image resizer.
* Can now use lazy blob existence checking to increase performance. Use `lazyExistenceCheck=true` to enable (warning: untested).
* Fixed bug where 'prefix' values not starting in ~ or / wouldn't be handled correctly.
* Fixed bug where images outside the prefix directory were assumed to be image files
* Now a nuget package

## [S3Reader](/plugins/s3reader)

* Can now fallback to IVirtualImageProvider if security restrictions prevent it registering as a VirtualPathProvider. Or, you can manually request it only register as an IVirtualPathProvider by setting `vpp="false"`. IVirtualImageProviders can only provide files to the image resizer.

## [RemoteReader](/plugins/remotereader)

* RemoteReader: Now overrides GetStream() instead of PreLoadImage() so that it can be used across all pipelines. Added support for underscores instead of periods in the domain name of the 'friendly' syntax. Allows users to avoid peculiar IIS configurations.

## [ImageHandlerSyntax](/plugins/imagehandlersyntax)

* WebImageResizer compatibility - now supports grayscale and invert commands when the SimpleFilters plugin is installed.

## [Logging](/plugins/logging)

* New Logging system - the Config.Current.Plugins.LogManager property and the Config.Current.Plugins.LoggingAvailable event allow plugins to support logging without having NLog as a dependency.
* New Logging plugin provides an NLog-based implementation of the logging system. This allows logging to be supported, but not required - no extra dependencies or overhead unless you add the Logging plugin!.
* The DiskCache plugin now supports detailed (optional) logging. Enabled by setting `<diskcache logging="true"/>`, installing the Logging plugin, and configuring NLog. 

# Core API changes

## Breaking API changes that affect nobody

* The ImageBuilder.Create() and ImageBuilder constructors now require 2 additional arguments, "IVirtualImageProvider virtualFileProvider" and "ISettingsModifier settingsModifier". As the ImageBuilder class shouldn't be created directly, this change should not affect anyone. Only subclasses of ImageBuilder should be affected - they will need to modify their constructors, .Create(), and .Copy() methods to include this new parameter. This change does not affect plugins or user code - only ImageBuilder subclasses (of which there are currently none).
* Removed unused constructor overload ImageBuilder(IEncoderProvider encoderProvider, IVirtualImageProvider virtualFileProvider) as it didn't offer anything new, and added to cost of implementing a subclass.
* The internal class BitmapHolder is no more. It has been replaced by ImageJob
* Non-breaking change: Config.Pipeline.GetFile now always returns an IVirtualFile instance, instead of an object which could either be a VirtualFile or IVirtualFile instance.

## API additions

* New class ImageJob - A class to contain all the parameters of a job. Makes alternate pipeline support easier.
* Added ImageBuilder.Build(Job job) overload. All other overloads now funnel through this method, and subsequently through extensible protected method BuildJob()
* ImageBuilder.LoadImage has a new overload with a 3rd parameter, restoreStreamPosition.
* New method for converting 99% of the 'source' object types into a stream: Stream ImageBuilder.GetStreamFromSource(object source, ResizeSettings settings, ref bool disposeStream, out string path, out bool restoreStreamPosition); Plugins can extend by subclassing BuilderExtension and overriding protected method GetStream (same parameters). This method makes it easier to build replacement pipelines.
* ImageBuilder, AbstractImageProcessor: Added PostDecodeStream() method, called at end of LoadImage method. Used by AutoRotate
* ImageResizer.Configuration.Logging namespace - ILogManager, ILogger, ILoggerProvider and PluginConfig support mean that the ImageResizer can support any logging library - with no extra dependencies. 


## Extensibility additions

* Alternate pipelines can now be implemented as BuilderExtension plugins instead of being forced to subclass ImageBuilder.

* AbstractImageProcessor: Added `protected virtual RequestedAction BuildJob(ImageResizer.ImageJob job)` Enables replacement pipelines to be implemented as a plugin.

* AbstractImageProcessor: Added `protected virtual Stream GetStream(object source, ResizeSettings settings, ref bool disposeStream, out string path, out bool restoreStreamPosition)` Allows RemoteReader and similar plugins to support alternate pipelines.
* ISettingsModifier plugins are now supported, and allow modified of resizing settings without subclassing BuilderExtension.


## Minor bug fixes

* Plugins missing a constructor don't crash the request; they just log an issue.
* If a plugin throws an exception during GetIssues, it is now logged as an issue instead of crashing the resizer.debug page.
* Earlier disposal of Pen and Brush instances used for rendering image padding, borders, and drop shadow.

## Deprecated

* ImageResizer.StretchMode and ImageResizer.CropMode are deprecated, and have been replaced by ImageResizer.FitMode


