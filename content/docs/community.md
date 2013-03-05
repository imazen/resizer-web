Aliases: /docs/wrappers /docs/contribute
Icon: github-alt

# ImageResizer Community

## Open forum for Ideas and Feature Requests

Please [use the UserVoice forum for ideas and feature requests](http://resizer.uservoice.com/forums/108373-image-resizer), so others can vote and comment on your proposals. The ImageResizer project isn't just about resizing. We're Lightroom as a web-service, but with a plugin model so things don't get bloated - and the community is free to innovate.

If your idea doesn't get enough votes to be developed by Imazen, don't despair - If you want to take a shot at implementing it, we'll help you out! We're generally willing to publish community plugins in the /Contrib folder, although you may prefer to host it on your own [GitHub repostiory](http://github.com), so we can link to it below.


## Community plugins

Here are a few we know about (leave a comment if we've missed one!)

* [CropImage.NET: The replacement for WebCropImage](http://cropimage.net)
* ImageStudio (found in /Contrib folder) by Zan Kavtaskin; upload & crop
* [ImageResizing.FluentExtensions by Ben Foster](https://github.com/benfoster/ImageResizer.FluentExtensions)
* [Eksponent CropUp - Plugin for weighted semi-auto cropping, with Umbraco integration](http://cropup.codeplex.com/) (Under active development at the moment)
* [ResponsivePresets plugin](https://github.com/mindrevolution/ImageResizer-ResponsivePresets)

* [StudioJS: Image editing studio in jQuery plugin form](https://github.com/nathanaeljones/studiojs)

* [jQuery NailThumb by Garralabs](http://www.garralab.com/nailthumb-serverside-demo.php)

Image PowerTOols module for Orchard
http://imagepowertools.codeplex.com/

http://ben.onfabrik.com/posts/image-resizer-fluent-extensions

## Community CMS modules

### Umbraco modules based on ImageResizer

* http://our.umbraco.org/projects/starter-kits/ubootstrap
* http://our.umbraco.org/projects/website-utilities/eksponent-cropup


### Orchard modules based on ImageResizer

* http://orchardimageresizer.codeplex.com/
* http://bigsitesdoneright.com/big-blog/orchard-cascade-gallery-tutorial-series
* https://github.com/pnmcosta/orchardcontribthumbnails/
* http://imagepowertools.codeplex.com/
* http://imagemultipicker.codeplex.com/

## Community articles

* [Scott Hanselman: NuGet Package of the Week: ImageResizer](http://www.hanselman.com/blog/NuGetPackageOfWeek11ImageResizerEnablesCleanClearImageResizingInASPNET.aspx)
* [Scott Hanselman: Dynamic Image Generation](http://www.hanselman.com/blog/BackToBasicsDynamicImageGenerationASPNETControllersRoutingIHttpHandlersAndRunAllManagedModulesForAllRequests.aspx)
* [Scott Hanselman (podcast): Deep inside image resizing and scaling with ASP.NET and IIS, with ImageResizing.net author Nathanael Jones](www.hanselminutes.com/313/deep-inside-image-resizing-and-scaling-with-aspnet-and-iis-with-imageresizingnet-author-na)


* [Greg Duncan, Channel 9: Funny, you look bigger in real life... Server side image resizing with the free and open source ImageResizer](http://channel9.msdn.com/coding4fun/blog/Funny-you-look-bigger-in-real-life-Server-side-image-resizing-with-the-free-and-open-source-ImageRes)

* [Nokia Developer Guide: Delivering image tiles to Windows Phone with ImageResizer](http://www.developer.nokia.com/Community/Wiki/Generating_Live_tiles_for_Windows_Phone_from_Live_Data#ImageResizer) (Note - while they're using an MVC action, we strongly suggest using the HttpModule instead if you wish to have caching work properly)
* [Nathanael Jones: Using JCrop with ImageResizer in 11 lines of javascript](http://nathanaeljones.com/573/combining-jcrop-and-server-side-image-resizing/)

* [Ben Foster: FluentExtensions for ImageResizer](
http://ben.onfabrik.com/posts/image-resizer-fluent-extensions)
* [cskardon: Using ImageResizer on Azure 2.0](http://geekswithblogs.net/cskardon/archive/2013/02/26/imageresizer-azurereader2-and-wellhellip-azure-duh.aspx)

* [heltBlank: Umbraco and ImageResizer](http://heltblank.wordpress.com/2012/02/13/imageresizing-net-and-umbraco-5-jupiter/)

* [uBootstrap for Umbraco](http://our.umbraco.org/projects/starter-kits/ubootstrap) now [includes ImageResizer to handle reponsive imaging needs](http://jlusar.es/ubootstrap-fluent-layout)

* [Frederik Vig: Add powerful image resizing, cropping and manipulation support to your EPiServer website](http://www.frederikvig.com/2013/01/add-powerful-image-resizing-cropping-and-manipulation-support-to-your-episerver-website/)
* [Anders Hattestad: Automatically change images in a responsive design to scale (EPiServer)](http://world.episerver.com/Blogs/Anders-Hattestad/Dates/2012/8/Automatically-change-images-in-a-responsive-design-to-scale/)

* [Dave Gardner: Building a Gallery Module for Orchard with ImageResizer (7-part series!)](http://bigsitesdoneright.com/big-blog/orchard-cascade-gallery-tutorial-series)

* [Bertrand Le Roy (Orchard author): State of .NET Image Resizing: how does imageresizer do?](http://weblogs.asp.net/bleroy/archive/2011/10/22/state-of-net-image-resizing-how-does-imageresizer-do.aspx) * Note the performance chart is bogus due to a mistake in the Bertrand's benchmark code. [The corrected chart](http://downloads.imageresizing.net/Oct29-2011-comparison.png) displays actual apples-to-apples data, instead of comparing low-quality and high-quality image resizing as the original benchmark does.

There are also over [50 StackOverflow posts about ImageResizer](http://stackoverflow.com/questions/tagged/imageresizer), although the overall question quality is low.


## Community Support

Many ImageResizer users [monitor StackOverflow for questions tagged `imageresizer`](http://stackoverflow.com/questions/tagged/imageresizer), and may answer your question before we can get to it. 

Please be courteous; vote good answers up, and mark them as accepted. Make sure your questions include a gist with the diagnostics page output, and you've included all relevant details and detailed error messages.

## Getting and contributing source code

If you're not sharing code, simply use the NuGet packages to get the latest binaries automatically, and [configure Visual Studio to download sources and symbols](http://www.symbolsource.org/Public/Home/VisualStudio) automatically for debugging.

ImageResizer and all plugins are developed on GitHub. E-mail your GitHub username to `support@imageresizing.net` and we'll give you access to the imazen/resizer repository. We happily accept most patches and pull requests we receive. 

http://github.com/imazen

http://github.com/nathanaeljones

[More info](/docs/git)



### Plugin development

See something on the [ideas forum](http://resizer.uservoice.com) that interests you? The plugin model means you can implement it independently. If it's general-purpose enough, I might put it in the standard download. 


### CMS Integration

Our goal is to support every CMS. And, we do, generally. But there's a lot of value in having deeper integration, so you don't have to manually add the querystring.

Dozens of CMSes have integrated the Core library natively, and we encourage that. Plugins have to be separately purchased, but they're quite affordable, and aren't usually needed for intranet or private installations.

Provide an open-source module that provides stronger integration between a CMS and ImageResizer, and you could be eligible for a free enterprise license or a 2YR Bronze support contract.




