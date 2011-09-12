
# Migrating Web.Config from V2 to V3

1. Search for "fbs.ImageResizer.InterceptModule" and replace it with "ImageResizer.InterceptModule". There should be 1 or 2 occurrences, in the `<modules>` and `<httpModules>` sections.
	It should look like this:
	
		<modules>
			<add name="ImageResizingModule" type="ImageResizer.InterceptModule"/>
		</modules>
	
2. At the top of the file, you should see a `<configSettings>` section. If not, add it, and then add `<section name="resizer" type="ImageResizer.ResizerSection"/>`.
	It should look like this:
	
		<?xml version="1.0"?>
		<configuration>
			<configSections>
				<section name="resizer" type="ImageResizer.ResizerSection"/>
		</configSections>
	
3. Add a `<resizer>` section after `</configSections>`:
	
		...
		</configSections>
		<resizer>
			<!-- This configuration mostly duplicates v2 default behavior-->
			
			<pipeline fakeExtensions=".ashx" vppUsage="Fallback" /> <!-- Optional, these are the defaults anyway -->
			
			<clientcache minutes="1440" /> <!-- defaults to 0, no expires header sent. -->
			
			<sizelimits imageWidth="1680" imageHeight="1680" totalWidth="3200" totalHeight="3200" />
				
			<diskcache dir="imagecache" subfolders="32"
						enabled="true" autoClean="true" hashModifiedDate="false" /> 
						
			<!-- defaults to  autoClean="false" and hashModifiedDate="true"
					 hashModifiedDate=true causes new files to be written when the source files change, but also prevents 
				   locking delays that can occur when trying to update a cached file on a busy site-->
					   
			<plugins>
				<add name="DiskCache" />
				<add name="PrettyGifs" />
				<add name="DropShadow" /> <!-- Only if you use the drop shadow feature -->
				<add name="AnimatedGifs" /> <!-- Only if you resize animated Gifs -->
				<add name="FolderResizeSyntax" /> <!-- Only if you use the /resize(x,y,f)/ folder syntax -->
			</plugins>
		</resizer>
4. Visit [/resizer.debug.ashx](/plugins/diagnostics) to make sure everything is working.

## Setting-by-setting explanation

* `ImageDiskCacheDir` is now `<diskcache dir="value" />` (defaults to "imagecache")
* `ImageCacheSubfolders` is now `<diskcache subfolders="value" />` (defaults to 32)
* `DisableCacheCleanup` is now `<diskcache autoClean="false" />` (defaults to false, no cache cleanup)
* `DiskCacheAlwaysInvalid`=true is the equivalent of `<diskcache enabled="false" />` (defaults to true, enabled).
* `ImageResizerMaxWidth` and `ImageResizerMaxHeight` are now `<sizelimits imageWidth="value" imageHeight="value" />` (See [SizeLimits](/plugins/sizelimiting) documentation for detailed info)
* `ImageResizerClientCacheMinutes` is now `<clientcache minutes="value" />` Defaults to 0 instead of 1440.
* `DisableCustomQuantization`=`true` is the same as removing `<add name="PrettyGifs" />` from the `<plugins />` section.
* `ResizeExtension` is now `<pipeline fakeExtensions=".ashx,.axd" />`. Multiple extensions can be separated by commas. Defaults to ".ashx", the safest choice.
* `MaxCachedImages` has been replaced by a more flexible system of cleanup criteria. Basically defaults to 12,800. 
* `DisableImageURLAuthorization` no longer exists, but can be implemented by handling the Pipeline.AuthorizeImage event and setting AllowAccess to true.
* `ImageResizerUseVirtualPathProvider` and `ImageResizerUseVirtualPathProviderAsFallback` have been replaced by `<pipeline vppMode="Fallback|Never|Always"" />`. Defaults to "Fallback".
* `AllowURLRewriting` has been removed. URL rewriting is permitted by default, but URL rewriting is also not performed by default, except for removal of fakeExtensions (".jpg.ashx" -> ".jpg"). 
*  The `/resize(x,y,f)/` syntax has been moved to a plugin, FolderResizeSyntax.





