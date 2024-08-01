# V2 release changelog

* v2.8 May 27, 2011 ([Upgrade notes from V2.6 to v2.8](/releases/2-8))

  * <span style="color:red;">Fixed serious limitation of ImageResizerMaxWidth/Height settings.</span>  
    These settings only control the size of the photo portion of the image. They do not limit the dimensions of the resulting bitmap. 
    
    **New behavior**: When the final dimensions of an image would exceed 2x the configured max width and height, the request will be ignored with the following message: "The specified image will be more than 2x the permitted size. Request terminated."
  * Fixed bug: Mime-type: image/x-png was being sent instead of image/png. **Causes Chrome to download images instead of displaying them.**
  * Fixed bug in disk caching system: **Cached files modified by just one day or one hour don't get updated.**
  * Fixed bug where **specifying both width and maxheight would cause width to be ignored.**
  * Fixed bug: Two simultaneous ImageManager.getBestInstance() calls at app startup could return two different instances.
  * Fixed bug causing Dictionary exception on the first request after the app was restarted. Only occurred if two simultaneous requests occurred. Only would happen once per app lifetime. 
  * Fixed potential bug: **Extremely** rare Access Denied message occurring on one of 2 simultaneous requests for a newly added source image. No reported occurrences.
  * Removed System.Data and System.Xml dependencies. 
* v2.6 Nov 11, 2010 (<a href="http://nathanaeljones.com/489">Upgrade notes from 2.1b to 2.6</a>)
  * Fixed bug where a NullReference exception would occur if the Authentication module didn't process the request. All requests appear anonymous now in that situation.
  * Fixed rounding bug and added regression test. New behavior is to round ALL values before performing drawing, but AFTER math is done. Was previously trimming a line of pixels off certain images.
  * Fixed border bug where border was drawn over top of padding.
  * Fixed threading bug with creating the web.config file. Two concurrent requests would cause an exception.
  * Fixed bug where no URL Authorization was occurring UNLESS DisableImageURLAuthorization=TRUE in web.config (This bug did not exist in v2.1b, only in custom versions sent to customers between Mar. 19 and Nov. 11)
  * Fixed SecurityException errors occurring on GoDaddy and in other low-trust environments: changed the Animation plugin to use static methods instead of reflection. Users of the animation plugin, contact me for an updated version.
  * Added support for splitting the image cache into subfolders, allowing scalability to millions of images:
  * Set "ImageCacheSubfolders" to the number of required folders.
  * Added support for resizing images from VirtualPathProviders.
    Set either <em>ImageResizerUseVirtualPathProvider </em>or <em>ImageResizerUseVirtualPathProviderAsFallback </em>to true to enable the functionality. In Fallback mode, the virtual path provider is only called if no physical file exists.
  * Added support for implementing cache-friendly database-driven image resizing using a VirtualPathProvider.
  * Added IVirtualFileWithModified and IVirtualBitmapFile. Allow custom virtual path providers to be cache-friendly and even send bitmaps directly to the image resizer. Great for implementing new image formats.
  * Added &scale=UpscaleCanvas mode. Instead of upscaling the image, the canvas expands to the specified Width and Height.
  * Added DisableImageURLAuthorization setting. Set to TRUE to disable additional URL authorization checking within the resizer (imagecache is still protected).
  * Added BuildImage overloads with VirtualFile support
  * Added static event hooks for URL rewriting on images (replaces CustomFolders.cs, although CustomFolders.cs still works).
  * CustomFolders.cs will be removed in the next major revision.
  * Added the ability to specify custom extension/ImageFormat mappings, in case your jpegs are named .cow or .pig for some strange reason.
  * Added TranslatePoint methods to allow simulation of a resize (useful for image map generation).
  * Added Size GetFinalSize() methods to ImageManager.cs for determining the resulting size of an image.
  * Performance boost: modified DiskUtil.UpdateCachedVersionIfNeeded to use 'cachedFile' instead of 'sourceFile' as lock/sync key.
* v2.1b Nov. 13, 2009 (<a href="http://nathanaeljones.com/438/version-2-1b-released/">Upgrade notes from 2.0 to 2.1b</a>)
  * Fixed: Fixed elusive performance bug in DiskCache that caused directory listings to run every image request.
  * Added: GIF/PNG dithering support!
  * Added: Zero-IIS-configuration installation mode! No wildcard mapping needed. Syntax: "image.jpg.axd?width=500"
  * Fixed: All requests are forced to pass through the UrlAuthorizationModule now. Previously, any URL rewriting (like customfolders.cs) caused URL auth rules to be circumvented. This was documented behavior, but a secure solution has now been found.
  * Added: DisableCustomQuantization setting to allow GIFs to be generated on servers where the Marshal class is prohibited.
  * Added: PerfTests project to run benchmarks on the image resizing and encoding code.
  * Added: ImageManager.BuildImage now accepts an HttpPostedFile instance for resizing, making upload and resize simple. Sample project included.
* v2.0rc2 Jun 3, 2009 (<a href="http://nathanaeljones.com/11181_Image_Resizer_2_0_Upgrade_notes">Upgrade notes from 1.2 to 2.0</a>)
  * Fixed: Extremely rare bug where rounding causes Bitmap to be initialized with a dimension of 0, and causes a Parameter exception.
    Occurred when resizing an image to < 2px in height or width (usually happens with 2x1000 size images, etc).
    Added regression test for 500x2 image resized to 100px wide.
  * Fixed: Typo (missing else) in SaveToNonSeekableStream. This method is for extensibility, and is not used by the Resizer directly.
    This method is now tested and part of the Regression tests (HandlerTest.ashx).

* v2.0rc1 May 21, 2009 (<a href="http://nathanaeljones.com/11181_Image_Resizer_2_0_Upgrade_notes">Upgrade notes from 1.2 to 2.0</a>)
  * Fixed: Transparency is preserved more reliably with GIF files. Certain GIF files were losing transparency because the way the color palette was constructed.
  * Fixed: .tif is now a supported input extension... previously only .tiff and .tff were allowed.
  * Added WatermarkSettings.cs class for watermarking. Easy to extend for your own use.
  * Converted ImageManager from a Static class to a normal class with a getBestInstance() static method. Allows easy plugin creation for ImageManager.
  * Added support for ?frame=1-x and ?page=1-x. You can now select frames from GIF images and pages from TIFF files. Removed ?time
  * Hashes are now SHA-256 instead of .NET 32-bit. They are base-16 encoded. This results in longer file names, but astronomically low chances of hash collisions.
  * Fixed upgrade notes link in upgrade notes.txt

* v2.0b May 16, 2009  (<a href="http://nathanaeljones.com/11181_Image_Resizer_2_0_Upgrade_notes">Upgrade notes from 1.2 to 2.0</a>)
  * Fixed: Incorrect aspect ratio issue if both maxwidth, width, and height are specified.<
  * Fixed: UNC hosted websites are now supported.
  * Added DisableCacheCleanup command, and made MaxCachedImages < 0 behave the same as DisableCacheCleanup=true
  * Fixed: rounding error that could cause a pixel line on the right and/or bottom sides of the image. Rare floating point rounding error in GDI native code. Added code to force rounding to be consistent.
* v2.0a Mar 4, 2009 (E-mail distribution)
  * Fixed: Cleanup routine can cause bottleneck on GetFiles() - fix so that Directory.GetFiles() only happens at startup and when items are added. Only affects sites with slow filesystems (or without filesystem caching), and with thousands of images.
  * Fixed: imagecache/ is not protected when AllowURLRewriting is enabled
http://localhost/resize(40,40)/imagecache/1639776677.jpg
bypasses it.  Added protection in the HttpModule.
  * Fixed: Potential issue in Quantizer.cs that may cause lines in GIF output.
  * Fixed Maxwidth/maxheight not getting picked up.
  * Fixed: Custom crop coordinates at 0 were being applied in the negative coordinate zone. Fixed so x1,y1 weren't affected, but setting x2 and y2 to 0 is bottom-right relative.
  * Changed flip to be after all operations, and added sourceFlip to replace its behavior.
  * Added -ignoreicc parameter and made ICC reading the default. ICC profiles are not written out - browser does not support them.

* v2.0a Jan 30, 2009 (E-mail distribution)
* v1.0 - August 6, 2008 (Initial release to the public.)
* v1.2 - Nov 23, 2008 ([Upgrade Notes from 1.0 to 1.2](http://nathanaeljones.com/11171_Image_Resizer_1_2_Upgrade_Notes)) ([Original product page](http://nathanaeljones.com/11131_Image_Resizer_v1_2_Product_Page))
