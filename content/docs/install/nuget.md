Aliases: /docs/nuget


# Installing the ImageResizer via NuGet

[NuGet](http://nuget.org) is a package manager for .NET, and a pretty good one. It's easy to set up, and friendly to use.

The ImageResizer is published as a NuGet package, as are nearly all of the plugins. If you have [NuGet](http://nuget.org) installed, you can right-click on your project and choose "Add Library Package Reference". Search for "ImageResizer", and you should see a [list of packages](http://www.nuget.org/List/Search?searchTerm=author%3A%20Nathanael%20Jones). Click Install, and you're done. You can install plugins with similar ease, but it's always good to check the [plugin's documentation](/plugins) to see if additional steps are required for activation.

## ImageResizer or ImageResizer.WebConfig ?

If you want to manually modify Web.Config, install the **ImageResizer** package. Otherwise, you can install the **ImageResizer.MvcWebConfig** package, which will install **ImageResizer**, then add the HttpModule and ConfigurationSection registration elements to Web.Config, and install MvcRoutingShim. If you are only running .NET 2.0, install `ImageResizer.WebConfig` insted.

The WebConfig package never deletes anything from your Web.config file, but it may duplicate elements if you have already installed the changes in a slightly different manner.

The WebConfig package is used by most of the sample packages.

If you're using ASP.NET MVC, you can install **ImageResizer.MvcWebConfig** to get everything working in one step. 

**Don't worry! All packages can be safely combined!** 


## Full list of available packages

The following is a list of NuGet packages available for V3.1. 

Click [here for the list on nuget.org that may be more up-to-date](http://www.nuget.org/List/Search?searchTerm=author%3A%20Nathanael%20Jones)

Packages denoted with [1] require a Performance Edition license or higher.
Packages denoted with [2] require a Creative or Elite edition license
Packages denoted with [3] require an Elite edition license.

Please note most Essential Edition plugins are contained in the core package `ImageResizer`

The Faces, FreeImage, and Security plugins do not yet have NuGet packages.

* ImageResizer
* ImageResizer.WebConfig
* ImageResizer.Mvc
* ImageResizer.MvcWebConfig
* ImageResizer.Plugins.DiskCache [1]
* ImageResizer.Plugins.PrettyGifs [1]
* ImageResizer.Plugins.AnimatedGifs [1]
* ImageResizer.Samples.Jcrop
* ImageResizer.Plugins.S3Reader [1]
* ImageResizer.Plugins.Watermark [2]
* ImageResizer.Plugins.SimpleFilters [2]
* ImageResizer.Plugins.AzureReader [1]
* ImageResizer.Plugins.AzureReader2 [1]
* ImageResizer.Plugins.AdvancedFilters [2]
* ImageResizer.Plugins.RemoteReader [1]
* ImageResizer.Plugins.SqlReader [1]
* ImageResizer.Plugins.PsdReader [3]
* ImageResizer.Plugins.CloudFront [1]
* ImageResizer.Plugins.PdfRenderer
* ImageResizer.Plugins.SeamCarving [2]
* ImageResizer.Plugins.WhitespaceTrimmer [2]
* ImageResizer.Plugins.BatchZipper [3]
* ImageResizer.Plugins.Wic [2]
* ImageResizer.Plugins.Logging
* ImageResizer.Plugins.PsdComposer [3]
* ImageResizer.FluentExtensions (third-party)
* ImageResizer.FluentExtensions.Mvc (third-party)
* ImageResizer.Plugins.MongoReader [3]
* ImageResizer.Plugins.WebP [2]
* Imazen.WebP
