Date: June 16 2011
FullFile: http://downloads.imageresizing.net/Resizer3-alpha-10-full-Jun-16-2011.zip
minfile: http://downloads.imageresizing.net/Resizer3-alpha-10-min-Jun-16-2011.zip

# Resizer 3 alpha 10 - Jun 16 2011


### Changes since [alpha 9 (Jun 8)](/releases/3-alpha-9)

# Bug fixes

* Fixed bug in ImageBuilder.Build() - ArgumentException if Build() is called twice on the same HttpPostedFile instance (due to stream being disposed).  LoadImage() no longer disposes the HttpPostedFile instance, and even restores the position of the stream afterwards.
* DiskCache: Fixed bug where cached files were not being re-used when hashModifiedDate=true or when using S3Reader in fast mode.


# New features

* Added new overload: string Build(object source, object dest, ResizeSettings settings, bool disposeSource, bool addFileExtension)
 Now you don't have to calculate file extensions when saving a resized image to disk - simply pass an extension-less path to 'dest' and get the resulting physical path back from the overload.
* VirtualFolder now supports multiple instances (you can create multiple virtual folders now)
* Added first draft of AzureReader (Created by Wouter Alberts with a bit of help from me). Can be found in the Contrib folder.
* Added PathUtils.RemoveExtension and PathUtils.RemoveFullExtension
* S3Reader: Added support for useSsl, accessKeyId, and secretAccessKeyId configuration in Web.config. Changed includeModifiedDate setting to checkForModifiedFiles .


# New examples

* ComplexWebApplication: Added example watermarking based on folder and output image size
* ComplexWebApplication: Added example on how to generate multiple image versions during upload.

# NuGet Packages

There are now [NuGet](http://nuget.org) packages for 8 of the 12 paid plugins, as well as 2 packages for the core and 1 sample project.