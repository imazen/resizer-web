# V2 to V3 migration guide

1. [Purchase the v3 Performance Edition](/plugins/upgradefrom2). .
2. Back up your project, or at least the Web.Config file, /bin, and /App_Code/ImageResizer folders.
3. Delete your /imagecache/ folder.
4. With version 2, did you customize [CustomFolders.cs](customfolders) or [WatermarkSettings.cs](watermarksettings)? Follow the links for instructions.
5. Remove the old ImageResizer.dll reference and/or the App_Code\ImageResizer folder.
4. Add the following dlls to your project, from the `dlls\release\` folder in the purchased download.
	* ImageResizer.dll 
	* ImageResizer.Plugins.DiskCache.dll
	* ImageResizer.Plugins.PrettyGifs.dll
	* ImageResizer.Plugins.AnimatedGifs.dll (optional, only if you resize animated gifs)
5. [Migrate your web.config file settings](/docs/2to3/configuration).
