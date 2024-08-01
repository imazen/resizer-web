Date: June 8 2011
FullFile: http://downloads.imageresizing.net/Resizer3-alpha-9-full-Jun-8-2011.zip
minfile: http://downloads.imageresizing.net/Resizer3-alpha-9-min-Jun-8-2011.zip
Summary: 8 bug fixes and 8 new features

# Resizer 3 alpha 9 - Jun 8 2011

### Changes since [alpha 8 (Jun 2)](/releases/3-alpha-8)


## Fixed bugs

* Content-type "image/jpeg" would be sent for PNG and GIF images when 'format' was not specified.
* Visiting the resizer.debug page would result in a NullReferenceException when the DiskCache was installed and autoClean=false or enabled=false was configured.
* ResizeSettings: Setting CropTopLeft and CropTopRight had no effect, the values weren't saved. (Setting ["crop"] always worked).
* Incorrect behavior when invalid (non-numeric) values were used for width, height, maxwidth, maxheight, shadowWidth, andgle, and rotate. The intended behavior was to interpret invalid values as 'unspecified'. Instead, they were interpreted as '0'. 
* Fixed potential NullReferenceException masking an ImageCorruptedException in LoadImage (wrong exception thrown).
* ResizeSettings: Rotate no longer rounds values to the nearest integer.
* ResizeSettings: Setting the BackgroundColor, PaddingColor, or BorderColor properties would cause the alpha portion of the assigned color to be ignored. Reading these properties when the underlying string values were invalid (like "ghhaggee") could have caused an Exception to be thrown instead of returning Color.Transparent. 
* ClientCache.Uninstall() returned false, despite uninstalling correctly. 

## New features

* Added support for image margins (outside the border and drop-shadow or other effect). Added ResizeSettings.Margin. 
* Added support for [independent, separate control over caching and processing](/docs/process-and-cache). (&cache=no/default/always, &process=no/default/always). This allows the DiskCache to be used for non-image data. For URLs without image extensions, however, you'll still need to add [a PostAuthorizeRequestStart handler](/docs/howto/cache-non-images).
* Added Pipeline.SkipFileTypeCheck, Pipeline.ModifiedQueryString, Pipeline.PreRewritePath so PostAuthorizeRequestStart can customize the processing and caching behavior.
* Added ResizeSettings.ToString(). Better debugging!
* Added ResizeSettings.Process property.
* Added PathUtils.GetExtension(). 


## Potentially breaking API changes

* ResizeSettings.get and .set are now protected instead of public, as they should have been originally.
* protected variable ImageBuilder.encoderProvider is now \_encoderProvider for CLS compliance.

## New features in SqlReader

* Now supports char, nchar, varchar, and nvarchar identifiers for images.
* Now supports loading and caching non-image files from SQL binary columns.
* SqlReaderSample: Added support for uploading and listing regular files. Added "Remove all images" button.
* Now supports named connection strings so you don't have to duplicate configuration. Uses the "ConnectionStrings:namedKey" syntax like the ASP.NET declarative data source controls.
* Now provides better diagnostics
* SqlReaderSettings: Added VirtualPathPrefix readonly property, StripFileExtension boolean property, and IsIntType, IsStringType methods.

## Tests

The bug fixes of this release were primarily driven by unit test discoveries. Code coverage doubled with this release, and I'm aggressively adding regression tests for everything I fix.


### Remaining known bugs

None. Isn't this when most people mark a product as stable?



