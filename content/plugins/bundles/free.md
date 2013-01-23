Aliases: /plugins/free
Bundle: free
Flags: bundle
Cost: This bundle is 100% free. All bundles include source code.


# Free bundle

The first 18 of the following plugins are included in the [free download](/download) and are under the [Freedom license](/licenses/freedom).

The first 16 can be found in the ImageResizer.Plugins.Basic namespace

* **[DefaultEncoder](/plugins/defaultencoder)** (default) - Adjustable jpeg compression, 24-bit PNG with transparency support, and standard .NET GIF encoding (which is very lousy).
* **[Diagnostics](/plugins/diagnostics)** (default) - Whenever you have an issue, go to localhost/resizer.debug and you'll probably be told what is wrong.
* **NoCache** (default) - Serves the resulting image directly from memory
* **[ClientCache](/plugins/clientcache)** (default) - Sets Cache-control, Expires, and Last-modified headers for optimum performance.
* **[SizeLimiting](/plugins/sizelimiting)** (default)- Limit maximum resolution of photos, or the total size of all processed images.
* **[Image404](/plugins/image404)** - Supply default images instead of a 404 when an image is missing. 
* **[VirtualFolder](/plugins/virtualfolder)** - Create an IIS-like virtual folder that works in Cassini as well as IIS, and doesn't require IIS configuration.
* **[DropShadow](/plugins/dropshadow)** - Adds drop-shadow feature (shadowOffset, shadowWidth, shadowColor)
* **[Gradient](/plugins/gradient)** - Create gradients from css, js, or html: /gradient.png?color1=FFFFFFAA&color2=BBBBBB99&width=10&width=10&rotate=90.
* **[FolderResizeSyntax](/plugins/folderresizesyntax)** - Resize images without using the query string.
* **[ImageHandlerSyntax](/plugins/imagehandlersyntax)** - Migrate websites from other image resizing handlers without breaking any URLs.
* **[SpeedOrQuality](/plugins/speedorquality)** - Gain a 15-30% speed boost by sacrificing rendering quality.
* **[Presets](/plugins/presets)** - Created named settings groups and and reference them with ?preset=name instead of specifying them all in the URL
* **[AutoRotate](/plugins/autorotate)** - Use the EXIF rotation data from the camera to auto-rotate your images.
* **[DefaultSettings](/plugins/defaultsettings)** - Allows you to configure the default setting values when commands (like `scale`) are omitted
* **[IEPngFix](/plugins/iepngfix)** - Automatically serve GIF versions of PNG files to IE6 and below clients. Opt-in or opt-out, very configurable.

These 3 plugins are in separate assemblies due to their dependencies

* **[Logging](/plugins/logging)** - Allows logging through NLog
* **[MvcRoutingShim](/plugins/mvcroutingshim)** - Prevent MVC Routes from taking over the ImageResizer's requests.
* **[PdfRenderer](/plugins/pdfrenderer)** - Render PDFs to images dynamically, then crop or process them as an image. **[Under a different license](/licenses/pdfrenderer) due to its use of GPL components**.


Check out the [maturity chart](/plugins/maturity) to see which plugins are the most stable.