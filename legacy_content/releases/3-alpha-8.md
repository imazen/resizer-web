Date: June 2 2011
FullFile: http://downloads.imageresizing.net/Resizer3-alpha-8-full-Jun-02-2011.zip
minfile: http://downloads.imageresizing.net/Resizer3-alpha-8-min-Jun-02-2011.zip
Summary: 4 core bug fixes, 2 new sample projects, and the important fixes to the DiskCache, SqlReader, and AnimatedGifs plugins

# Resizer 3 alpha 8 - Jun 2 2011



### Changes since [alpha 7 (May 26)](/releases/3-alpha-7)


### API changes (core)

* BuilderExtension/AbstractImageProcessor): Renamed OnBuildToStream to buildToStream
* PipelineConfig: Added PreRewritePath convenience property for Items[ModifiedPathKey]
* PathUtils: Added SetExtension, GetFullExtension, and AddExtension methods

### Bug fixes (core)

* Build(): Reading a corrupted image with Build() would cause a NullReferenceException instead of a ImageCorruptedException.
* Build(source,settings,disposeSettings) was ignoring the 'disposeSetting' boolean. Fixed.
* Build(LoadImage(stream),dest,settings,disposeSettings=false) was disposing the stream, due to a boolean logic error. Only affects nested LoadImage() calls such as used here.
* buildToStream now calls plugin methods

## Bug fixes (Plugins)

### DiskCache 
* autoClean=true now works (it was just pretending to work in previous releases) Once this was discovered, many more bugs came to light and were fixed.
* You can now configure the CleanupStrategy settings through XML. (See [the DiskCache docs](/plugins/diskcache) for details.
* DiskCache: New behavior with last accessed times. Since NTFS doesn't update them in Vista and up, we now explicitly update the index cache when we use a file. When refreshing file info from disk, the more recent 'accessed' value is kept.   To preserve the last-accessed value across app restarts, we lazily flush lastaccessedutc values to disk using the worker queue.

### AnimatedGif plugin
- Was also just pretending to work before. I somehow missed the test failure (yes, I had a manual test for it).
- Now properly extends BuilderExtension instead of AbstractImageProcessor - so it can actually resize GIFs.
- Uses c.CurrentImageBuilder.Build instead of this.buildToBitmap (so it actually encodes properly)
- Now uses source.RawFormat to filter GIF images instead of checking the output type. No longer swallows ExternalException, since we've found the cause, I think.
 
### SqlReader plugin

* Fixed configuration bug: Setting ImageIdType would incorrectly throw an exception.
* Behavior change: Now throws FileNotFoundException when an image doesn't exist, instead of causing a NullReferenceException later on.

## Samples and Documenation

* Added JCropExample ([read the article](http://nathanaeljones.com/573/combining-jcrop-and-server-side-image-resizing/))
* Added SqlReaderSample - Shows how to use the SqlReader plugin to resize and upload images to SQL.
* Added ComplexWebApplication\CropExample showing how to use jCrop with the image resizer
* ComplexWebApplication\UploadSample.aspx now works with multiple upload controls. Added commented-out code showing how to get a byte array for upload to SQL, etc.
* Removed 800x600 limitation on ComplexWebApplication - was accidentally left in during last release.
* Added some more sample pics


## Tests

* Added DiskCacheWebTest for real-world testing of the DiskCache cleanup worker
