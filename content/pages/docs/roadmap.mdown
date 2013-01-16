Flags: hidden

# Roadmap

This roadmap is preliminary

## 3.X - early 2013

* Add simple domain-based DRM.

## 4.0 - mid 2013

* Require .NET 3.5 instead of .NET 2, so extension methods and MVC can be supported in Core.
* Switch to a 'hints'-based plugin lookup model, so we can support .NET 4.X lazy initialization better.
* Migrate all API calls to use the `Instructions` class instead of `ResizeSettings`. This will eliminate the need for consumers to reference System.Drawing, and fix a number of long-standing limitations.
* Modify ImageJob so it can track source and final image dimensions
* Provide simplified virtual file API.
* Enhance InterceptModule extensibility


## 4.X

* Add metadata support
* Add ImageRules plugin
* Integrate FluentExtensions and add MVC URL and HTML helpers

## 5.0 - 2014

* Require .NET 4.5
* Use .NET 4 & WebActivator so the HttpModule doesn't have to be registered in Web.config anymore.
* Support async/await




## Backlog

* Support for ActionResults (although they can never be as fast as the HttpModule itself)
* Make extensible system for determining if the background color needs to be applied

* ImageResizer.Util Assembly Attribute classes will be moved to ImageResizer.Configuration

* No APIs will directly reference System.Drawing. A wrapper class will permit System.Drawing, WIC, WPF, FreeImage, or byte array images instead.
* ImageResizer.Encoding namespace will move to ImageResizer.Plugins.Encoding or ImageResizer.Configuration.Encoding
* All ImageResizer.Util classes will be reorganized or moved elsewhere
* ImageResizer.Configuration.Config will move to ImageResizer.ImageConfig
