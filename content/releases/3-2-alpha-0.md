Date: June 3 2012
FullFile: http://downloads.imageresizing.net/Resizer3-2-alpha-0-full-Jun-3-2012.zip
MinFile: http://downloads.imageresizing.net/Resizer3-2-alpha-0-min-Jun-3-2012.zip
Summary: 11 bug fixes (reliability improvements in WicBuilder, Watermark, WhitespaceTrimmer, SqlReader), heavy refactoring, 5 new draft plugins
ShortVersion: 3.2.0
Layout: release
Libs: plusone
Tags: releases

# Resizer 3.2 alpha 0 - June 3 2012

**Note: this release has a compatibility issue with .NET 4 and VB.NET. Use [3.2.1 instead](/releases/3-2-alpha-1).**

This is an **alpha** release containing heavy refactoring. Hundreds of changes were made to more than 258 code files. While the changes were quadruple-checked, there may still be some bugs. 

Be the first to report a given bug to support@imageresizing.net and claim the bounty! The best place to look for bugs is probably in querystring parsing, or the newly added Instructions class.

**Note for NuGet users: The latest ImageResizer.WebConfig package may insert a duplicate element in Web.config. Simply delete the one that doesn't include `requirePermission="false"`.**

	<section name="resizer" type="ImageResizer.ResizerSection"/>
	<section name="resizer" type="ImageResizer.ResizerSection" requirePermission="false"/>

## Known bugs still in this release

* S3Reader has concurrency issues when accessing S3 buckets over SSL. This issue existed in previous releases. The temporary workaround is to only use public buckets with SSL disabled. The next release will migrate from LitS3 to AWSSDK to avoid this and potentially other undiscovered issues.

## What didn't make the cut, but was expected to

* URL Builder API & MVC URL/HTML helpers; I need more users to volunteer for private beta testing before I can publish this kind of API. Please e-mail your Github username to `support@imageresizing.net` if you can volunteer.
* GetCurrentConfig - multi-tenanting support for Umbraco & Orchard. 


## Bug fixes in Core (ImageResizer.dll)

* Fixed background transparency bug when using `s.alpha` on a jpeg image.
* Fixed bug where specifying both `maxwidth` and `width` or `height` and `maxheight` would cause 'mode' to be ignored, assuming it to be 'max'.
* Fixed bug where ResponseHeaders wouldn't convert LastModified value to UTC before checking against UTCNow, triggering an ArgumentException from the ASP.NET framework for invalid modified dates. (Usually, from SqlReader)
* Fixed Diagnostics page false error: `Virtual path outside of the current application is not supported.` 

## Bug fixes in plugins

* Watermark: Fixed `InvalidOperationException: Object is currently in use elsewhere.` issue.
* WhitespaceTrimmer: Upgraded to hotfix release of AForge, fixes AccessViolationException
* WIC: Fixed GC bug (underlying bytes were being disposed before WIC had finished reading them).
* SqlReader now assumes SQL modified dates are UTC instead of server-local. Bug effects: items with a modified date don't get cached until they are X hours old, where X is the time zone offset.
* SqlReader: Changed behavior - If UntrustedData is set, RequireImageExtension automatically becomes false to prevent recoding circumvention.
* All datasource plugins now support multiple instances
* SeamCarving: now triggered by just &mode=carve, both &mode=carve and &carve=true are not required.

## Major changes to Core

* All querystring parsing is now handled through `ImageResizer.ExtensionMethods` instead of `ImageResizer.Util.Utils`. Update your custom plugins.
* All stream copying is now handled through `ImageResizer.ExtensionMethods` instead of `ImageResizer.Util.StreamUtils`.
* Enumeration parsing and serialization is now handled through `ImageResizer.ExtensionMethods`, to allow support for alternate (yet unlisted) variants for given values, and for custom serialization preferences.
* `ImageResizer.Util.ParseUtils` was introduced to restore `System.Drawing.Color` parsing and serialization, and it contains some aliases to NameValueCollectionExtensions.
* System.Drawing dependencies are being minimized. Introduced enumerations `OutputFormat`, `FlipMode`, `AnchorLocation`, `GrayscaleMode`, `JpegSubsamplingMode`, and class `BoxPadding` into root `ImageResizer` namespace.
* The new MVC-friendly `Instructions` class is replacing `ResizeSettings`, and adding support for more of the available commands. The two are easily convertible via their constructors: `new ResizeSettings(new Instructions())` or `new Instructions(new ResizeSettings)`.
* CLSCompliant has been set to false for the ImageResizer.dll assembly. While it's generally CLS compliant, some protected members don't qualify. I don't expect this change to have any ill effects.
* Implemented new rendering stage, PreRenderImage (and matching ImageState.preRenderBitmap variable). This stage permits 'mid-resizing' operations to take place in a chained manner, like seam carving, FreeImageResizing, Red-eye removal, etc. 
* Added support for source file caching plugins, via `IVirtualFileCache` and `IVirtualFileSourceCacheKey`.
* Added support for opt-in automatic native dependency installation with the new `NativeDependencyManager` class and the `NativeDependenciesAttribute` assembly attribute. Extremely useful for PdfRenderer, RedEye, Faces, and FreeImage plugins. 
* Removed ImageResizer.X, ImageResizer.Plugins.X, and ImageResizer.Plugins.Pro.X class location patterns. I.E, you can no longer specify `<add name="Plugins.DiskCache.DiskCachePlugin" />` or  `<add name="DiskCache.DiskCachePlugin" />`, only `<add name="DiskCache" />` or `<add name="ImageResizer.Plugins.DiskCache.DiskCachePlugin" />`.
* Added ResponseArgs.GetSourceImage so plugins can override the entire processing method to, say, return JSON instead of an encoded image.


## Minor changes to Core

* PathUtils now (generally) supports parsing URLs with fragments
* PathUtils.ParseQueryStringFriendly no longer assumes a path is a querystring unless it contains '='.
* Renamed PathUtils.FromBase64UToButes to FromBase64UToBytes
* Removed stub 'Caption' plugin and legacy FriendlyUrls plugin (now called FolderResizeSyntax).
* Querystring commands that accept comma-delimited lists: leading and trailing commas are now ignored, they no longer indicate 'empty' slots.


## Minor additions to Core

* PolygonMath.Dist(a,b)
* PolygonMath.GetShortestPair(poly)
* PolygonMath.NormalizeTo90Intervals
* PolygonMath.CombineFlipAndRotate
* PolygonMath.GetCroppingRectange
* Introduced ImageResizer.Util.ParseUtils as a replacement for certain Obsolete Utils methods. 
* Added Plugins.GetOrInstall<T>()
* Added Plugins/ImageStudio stub project.
* Added AWSSDK, Newtonsoft.Json, and OpenCVSharp to Plugins/Libs

## Marked obsolete in Core

* ImageResizer.Util.Utils (moved to extension methods and ParseUtils)
* ImageResizer.Util.StreamUtils (moved to extension methods)
* ImageResizer.Util.UrlHasher (moved to DiskCache)
* ImageResizer.StretchMode (Use FitMode.Stretch instead)
* ImageResizer.CropMode (Use FitMode.Crop instead)
* ImageResizer.CropUnits (Use cropxunits and cropyunits instead)
* ImageResizer.ResizeSettings was not marked obsolete, but will be in a future release. Time to start using Instructions.cs

# Plugins

This release includes the following new draft plugins: [RedEye](/plugins/redeye), DiskCache\SourceMemCache, ImageInfoAPI, Encrypted, and [Samples\CustomOverlayPlugin](/plugins/customoverlay). 
These plugins are not yet alpha, and will be changing before their final release.

## AdvancedFilters

* Changed the way blur/a.blur, sharpen/a.sharpen, a.removnoise, and a.oilpainting values are interpreted - With this release, your existing images may become slightly blurrier or sharper if you use these commands. This change was only made after consulting all registered users of the plugin. This change makes the specified radius values percentages of the image size. This will allow &blur=5 to have the same effect regardless of the image size, as expected. To be exact, the value will be interpreted as 1/1000ths of the smaller of the image width and height. This provides both granularity and very good consistency.

## AzureReader

* Now supports multiple instances

## DiskCache

* Added SourceMemCache plugin prototype to DiskCache.dll. 

## FreeImage

* Now supports downloadNativeDependencies="true" auto-install!
* FreeImageResizer now supports PreRenderImage system

## MongoReader

* Now supports multiple instances and IVirtualFileSourceCacheKey.

## PsdReader

* Now ignores requests where an alternate decoder is requested, and always attempts decoding with `decoder=psdreader` is specified.

## RedEye

* Alpha version released - supports JSON API for eye detection, URL API for correction.

## RemoteReader

* Added support for extension-less remote URLs.
* Added support for IVirtualFileSourceCacheKey.
* Added alpha support for XML-defined URL pattern whitelisting. (Needs testing)


## S3Reader

* Added support for IVirtualFileSourceCacheKey 
* Added support for multiple instances
* Added alpha support for RequireImageExtension, CacheUnmodifiedFiles, and UntrustedData settings

## SeamCarving

* Added alpha support for manual object removal/preservation with carve.data, LZW/custom dictionary-derived compressed block array.
* Implementation not fully complete.

## Security/Encrypted

* Added Plugins/Security project
* Added first draft of the Encrypted plugin

## SimpleFilters

* Added draft support for `s.roundcorners` command, supporting single and individual radii.

## SqlReader

* Added multi-instance support
* SqlReader: Added checkForModifiedFiles setting - (eliminates per-request DB hit when false).
* Fixed bug: SqlReader now assumes SQL modified dates are UTC instead of server-local. Bug effects: items with a modified date don't get cached until they are X hours old, where X is the time zone offset.
* Changed behavior - If UntrustedData is set, RequireImageExtension automatically becomes false.

## Watermark

* Fixed bug: InvalidOperationException: Object is currently in use elsewhere.

## WhitespaceTrimmer

* Eliminated use of AForge.UnamangedImage, which seems to have solved some memory consistency issues.
* Got hotfix from AForge author to solve AccessViolationExceptions.

### PdfRenderer

* Now supports downloadNativeDependencies="true" auto-install!


