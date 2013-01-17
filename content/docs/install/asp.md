# Guide for ASP developers

Users of ASP can leverage the ImageResizing library as easily as those using ASP.NET. 

To install the HttpModule so that you can use the URL API (`image.jpg?width=100`), [follow these quick steps](/docs/install/administrators). 

To use the API via COM, run \dlls\release\COMInstaller.exe and click "Install".  [register ImageResizing.dll](/docs/howto/use-from-com). 

## VBScript COM API example

	Set c = CreateObject("ImageResizer.Configuration.Config")
	c.BuildImage "tractor.jpg", "tractor-rotated.jpg", "rotate=45"

## JScript COM API example

	var c = new ActiveXObject("ImageResizer.Configuration.Config");
	c.BuildImage("tractor.jpg","tractor-rotated.jpg", "rotate=45");


### Using plugins

	Set c = CreateObject("ImageResizer.Configuration.Config")
	' This line installs the plugin, so it can enhance GIF output quality
	CreateObject("ImageResizer.Plugins.PrettyGifs.PrettyGifs").Install(c) 
	c.BuildImage "tractor.jpg", "tractor-rotated.gif", "rotate=45&format=gif"



### List of full plugin names

When using a plugin with the COM API, you must use the full name of the plugin, not the shortened one. 

The following are the full plugin names (as of July 26, 2011)


	ImageResizer.Plugins.Basic.VirtualFolder
	ImageResizer.Plugins.DiskCache.DiskCache
	ImageResizer.Plugins.PsdReader.PsdReader
	ImageResizer.Plugins.PrettyGifs.PrettyGifs
	ImageResizer.Plugins.Basic.Image404
	ImageResizer.Plugins.AnimatedGifs.AnimatedGifs
	ImageResizer.Plugins.Basic.Gradient
	ImageResizer.Plugins.Basic.FolderResizeSyntax
	ImageResizer.Plugins.SimpleFilters.SimpleFilters
	ImageResizer.Plugins.CloudFront.CloudFrontPlugin
	ImageResizer.Plugins.RemoteReader.RemoteReaderPlugin
	ImageResizer.Plugins.AdvancedFilters.AdvancedFilters
	ImageResizer.Plugins.CloudFront.CloudFrontPlugin
	ImageResizer.Plugins.SeamCarving.SeamCarvingPlugin
	ImageResizer.Plugins.Watermark.WatermarkPlugin
	ImageResizer.Plugins.SeamCarving.SeamCarvingPlugin
	ImageResizer.Plugins.S3Reader.S3Reader
	ImageResizer.Plugins.SqlReader.SqlReaderPlugin
