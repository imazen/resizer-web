Date: May 15 2011
FullFile: http://downloads.imageresizing.net/Resizer3-alpha-5-full-May-15-2011.zip
Tags: releases
Summary: 7 bug fixes, 5 API changes, and 3 new plu

# Resizer 3 alpha 5 - May 15 2011

* Version 3 alpha 5 - May 15 2011 
* * [Download everything: source, binaries, and samples](http://downloads.imageresizing.net/Resizer3-alpha-5-full-May-15-2011.zip) 
* * [Download core binary only](http://downloads.imageresizing.net/Resizer3-alpha-5-min-May-15-2011.zip)

## Changes since alpha 3 (May 2)

### Bug fixes

* Fixed rounding bug which would occasionally cause a gap between an image and its border
* Png files are now served with the mime-type image/png instead of image/x-png. Chrome didn't support 'x-png' for individual requests.
* Added support for GoDaddy hosting (which prevents UrlAuthorizationModule.CheckUrlAccessForPrincipal calls).
If required permissions do not exist, (a) an issue will be logged, and (b) url authorization rules will not take effect.
* All DLls now share the same version number and assembly information (except title and guid).
* PsdPlugin loads properly now
* Diagnostic plugin now works in Classic mode, just add ".ashx". (/resizer.debug.ashx)
* Fixed build paths - some plugins were not building to the dlls directory

### Managed API Changes

* The **[SizeLimiting](/plugins/sizelimiting)** plugin is now installed by default! This helps protect against RAM usage DOS attacks. SizeLimiting now defaults to imageWidth=0, imageHeight=0, totalWidth=3200, totalHeight=3200. (imageWidth/Height were 1680x1680)
* Replaced LoadImageFailed overloads with DecodeStream and DecodeStreamFailed methods. (Allows plugins to decode alternative formats more easily)
* Replaced the Pipeline.PostAuthorizeImage event with Pipeline.AuthorizeImage. The new event allows handlers to prevent (as well as create) access denied responses by simply changing the default of "e.AllowAccess".
* Moved exception classes to the ImageResizer root namespace.
* Moved PathUtils to the ImageResizer.Util namespace
* Moved SafeList and ReverseEnumerator to the Collections namespace/folder. Added ReadOnlyDictionary class.


### New features

* Added FriendlyUrls plugin
* Added AdvancedFilters plugin
* Added CloudFront plugin
* Added Url rewriting example to ComplexWebApplication
* Added SamplePlugin example to ComplexWebApplication
* Added *lots* of docs
* Watermark plugin now supports overlays that are virtual files (such as 'gradient.png')
* Added support for modifying the path during PostAuthorizeRequest, using context.Items\[Config.Current.Pipeline.ModifiedPathKey\] (Enabling feature for CloudFront plugin)
