Date: May 26 2011
FullFile: http://downloads.imageresizing.net/Resizer3-alpha-7-full-May-26-2011.zip
minfile: http://downloads.imageresizing.net/Resizer3-alpha-7-min-May-26-2011.zip
Tags: releases
Summary: 3 stability fixes, jCrop support, COM support, better diagnostics.
Layout: release

# Resizer 3 alpha 7 - May 26 2011



## Changes since [alpha 5 (May 15)](/releases/3-alpha-5)

### Stability-related bug fixes

* Fixed serious bug introduced in alpha 5: Underlying stream is disposed before the bitmap instance is disposed. Affected all Build() overloads. This was primarily introduced with the *Replaced LoadImageFailed overloads* API change in 3.0.5, when streams became used universally instead of only for virtual files and passed Stream instances. This issue can manifest as an InvalidOperationException, or any of many 'random' GDI-related messages. Often appears when using the Watermark or AnimatedGifs plugin. See Core/gdi-bugs.txt for details on how this and all related issues were solved.
Bitmaps are now Tagged with a BitmapTag instance that references the underlying stream, stopping accidental garbage collection issues. 
* Fixed leak of intermediate Bitmap in Bitmap Build(source, settings) overload. Would still be quickly garbage collected due to being gen 0, but still incorrect behavior.
* Fixed potential threading bug in the Watermark plugin (related to concurrent cached Bitmap access). Important update for users of the Watermark plugin.

## New features

* Added first draft of 'cropxunits' and 'cropyunits'.
	These can be set to a decimal value.
	If set to a decimal value, crop units for that dimension will be interpreted as relative to the value. This allows easy cropping without knowing the original size of the image.
	For example, ?crop=10,10,90,90&cropxunits=100&cropyunits=100 will crop a 10% border off each edge.
* Added first version of ImageResizerGUI, a **WPF app for batch resizing images**. 
* **Added COM support**, and Samples\ScriptAccess folder of examples and registration scripts.
* Added example ConsoleApplication
* /resizer.debug now lists supported file extensions and querystring keys
* When disabled, /resizer.debug provides instructions on enabling itself.
* LOTS of documentation fixes. 


## API changes

* **Build now *always* disposes 'source' unless disposeSource=false** (added 2 new overloads with disposeSource boolean). **This behavior is 'safer', and generally preferred.**
* The SizeLimiting plugin is now only loaded by default in *ASP.NET applications*. It doesn't make sense to restrict WinForms, Console, and WPF applications by default.
* LoadPlugins is called immediately if not running ASP.NET. Previously, it was only called on the first request in an ASP.NET application, and was never called in WinForms/WPF/Console apps.
* Changed behavior: BuilderExtension.DecodeStreamFailed is only called once if DecodeStream returns null.

### API Additions

* Added Plugins.Install and Plugins.Uninstall convenience methods
* Added Plugins.VirtualImageProviders - no longer using dynamic query. 
* Added default Config() constructor for COM compatibility.
* Added Config.BuildImage(source,dest,string) shortcut for COM-friendly access.
* Added Config.WriteDiagnosticsTo and Config.GetDiagnosticsPage() to simplify debugging.
* Added Build(source, settings, bool disposeSource) overload (see API changes)
* Added Build(source, dest, settings, bool disposeSource) overload (see API changes)


### Bug fixes

* Fixed numerous bugs in the Watermark plugin (which may have resulted in Overflow errors or rendering anomalies.)
  * Now works outside ASP.NET
  * Now handles simulation layouts
  * Now supports physical paths
  * Now produces integer dimensions and position for the watermark 
  * No longer incorrectly upscales watermark to fill entire image when keepAspectRatio is true. 
  * No longer acts incorrectly when padding and size add up to > 1 and valuesPercentages=true.
* ImageBuilder now uses the correct Config instance when selecting an encoder. Previously used Config.Current instead of the EncodeProvider passed in the constructor. Symptom: Plugin encoders were ignored by ImageBuilder unless present in Config.Current. 
* AnimatedGifs now works with independent Config instances.
* BatchZipper no longer sends both failure and success notifications for the same item.
* Removed many unneeded dependencies from PsdReader and PrettyGifs plugins
* LoadImage no longer disposes the stream if a stream was passed directly to it.


