Date: May 19 2015
Summary: Highlights of ImageResizer v4

# Highlights of ImageResizer v4

## Image scaling and image sharpening are up to 43x faster - and *are higher quality.* 

[FastScaling](http://imageresizing.net/docs/v4/plugins/fastscaling) provides a drop-in rendering engine to replace Graphics.DrawImage. It is the result of nearly 3 years of algorithm research, and provides unparalleled performance and quality.

It can work side-by-side with existing GDI+/System.Drawing-based plugins. 

Among other improvements, it can perform gamma-correct scaling. System.Drawing is only capable of scaling in the sRGB color space, which destroys image highlights and expands shadows.

Scaling in a linear light (left) preserves more of the snowflakes than scaling in sRGB (right).  

![Scaling in linear](https://s3.amazonaws.com/resizer-web/pluginexamples/snowing_300_linear.jpg)
![Scaling in sRGB](https://s3.amazonaws.com/resizer-web/pluginexamples/snowing_300_srgb.jpg)

## Performance

[Full benchmarking details here](http://imageresizing.net/plugins/fastscaling#benchmarks).

The short bars are how long v4 (with FastScaling) takes to resize a set of bitmaps. The skyscrapers are how long Graphics.DrawImage (v3) takes. On 15 threads, **FastScaling is 43.5x faster**. (Azure D14 instance). On my 4-core laptop, I still see a 30x delta.

![FastScaling vs DrawImage (Azure D14 instance)](http://z.zr.io/rw/scaling-benchmark.png?crop=30,40,-1,-1)

Bitmap scaling isn't the full picture, though. We have to decode and encode those bitmaps as well. This chart excludes I/O, but includes the full Stream-to-Stream BuildImage() process (decode, render, re-encode). Relative performance peaks at 9.6x faster (on 8 threads).

![FastScaling vs DrawImage (including decode and encode) (Azure D14 instance)](http://z.zr.io/rw/decode-scale-encode.png?crop=30,0,-1,-1)

<div class="well" style="font-size:22px; line-height:1.5em;">
<strong>Go <a href="http://imageresizing.net/licenses">buy a v4 license</a> and shut down those wasted virtual servers. Hurry.</strong> Each sale funds a significant amount of open-source software, and <strong>with enough resources we could revolutionize on-demand image processing</strong> - and <a href="https://github.com/imazen/Graphics-vNext">hopefully provide a graphics platform for .NET Core at the same time</a>. 
</div>

## Pipeline changes

* ImageResizer now applies URL rewriting performed in `Config.Pipeline.Rewrite` and `Config.Pipeline.RewriteDefaults` to all *image* requests if the rewriting results in an accessible physical or virtual file, even if the image is not processed by ImageResizer (this also fixes [#8](https://github.com/imazen/resizer/issues/8) and [#113](https://github.com/imazen/resizer/issues/113)). If the file is from a VirtualPathProvider, ImageResizer will assign the StaticFileHandler to ensure it is served (.NET 4+ no longer automatically serves files from VPPs) (Fixes [#140](https://github.com/imazen/resizer/issues/140)). 
* ImageResizer now fires `Config.Pipeline.ImageMissing` for all image 404s, not just those which would be processed.
* ImageResizer now fires `Config.Pipeline.AuthorizeImage` for all image requests, not just those processed. 
* DirectoryNotFoundExceptions now cause a 404.

Pipeline configuration defaults in v4:

        <pipeline vppUsage="Fallback" fakeExtensions=".ashx" defaultCommands="" dropQuerystringKeys="" authorizeAllImages="true" /> <!-- Other values for vppUsage are "Always" and "Never" -->

Suggested configuration:

        <pipeline defaultCommands="autorotate.default=true&fastscale=true" />


ImageResizer now offers both synchronous and async HttpModules. Replace `ImageResizer.InterceptModule` with `ImageResizer.AsyncInterceptModule` in `Web.config` to switch to async mode. AsyncInterceptModule requires that all your image providers implement `IVirtualImageProviderAsync` or inherit from BlobProviderBase. Of the official providers, `FFmpegPlugin` and `PsdComposerPlugin` do not yet implement async. 

## Installing custom plugins

In v3, we used a convention-based approach to generate dozens of possible fully-qualified type names, and then tried those against each loaded assembly. This approach was slow, and broke with .NET 4, which only loads assemblies with explicit references. We now maintain a [hints file](https://github.com/imazen/resizer/blob/develop/Core/PluginLoadingHints.cs) (which includes the assembly name), and use that to ensure a faster and more reliable load-time experience.  

**New in v4:** When installed via `Web.config`, custom plugins will need to be referenced by their fully-qualified name, such as "MyRootNamespace.MyPluginNamespace.MyPluginClass, MyAssembly" 

## Providers

ImageResizer.Storage provides a standard, unified `BlobProviderBase` class with 90% of the functionality you need. Override `FetchMetadataAsync` and `OpenAsync`, and you'll have a full-fledged provider with async/sync pipeline support, metadata caching, and even (optional) exposure through the ASP.NET VirtualPathProvider system.

**Some configuration attributes have been changed to make providers more consistent**.

## Completely new [PDF rendering system based on Pdfium](/plugins/pdfiumrenderer).

Faster, more stable, and permissively licensed.



