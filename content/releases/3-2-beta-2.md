Date: June 20 2012
FullFile: http://downloads.imageresizing.net/Resizer3-2-beta-2-full-Jun-20-2012.zip
MinFile: http://downloads.imageresizing.net/Resizer3-2-beta-2-min-Jun-20-2012.zip
Summary: 3 bug fixes
ShortVersion: 3.2.2

# Resizer 3.2 beta 2 - June 20 2012

This is an beta release: Version 3.2 underwent heavy refactoring. Hundreds of changes were made to more than 258 code files. While the changes were quadruple-checked, there may still be some bugs. 
Be the first to report a given bug to support@imageresizing.net and claim the bounty! The best place to look for bugs is probably in querystring parsing, or the newly added Instructions class.

**NuGet users: The latest ImageResizer.WebConfig package may insert a duplicate element in Web.config when you upgrade. Simply delete the one that doesn't include `requirePermission="false"`.**

	<section name="resizer" type="ImageResizer.ResizerSection"/>
	<section name="resizer" type="ImageResizer.ResizerSection" requirePermission="false"/>
	
# Improvements in 3.2.2

* `Instructions` and `ResizeSettings` now offer generic `Get<>()` and `Set<>()` methods for culture-invariant parsing and serialization of primitive types. Introduced via new base class, QuerystringBase.

# Bug fixes in 3.2.2

* Finally eliminated [ExtensionAttribute-related compile-time warnings and errors](http://stackoverflow.com/q/10990536/166893) by removing extension attribute support altogether. The utilities are still usable as static methods, and the new QuerystringBase class minimizes the need for them now.
* Jason Morse fixed a bug in PdfRenderer - ampersands in PDF metadata would prevent the file from being rendered
* VirtualFolder plugin: Fixed bug that occurs when vpp="False" and when virtualPath="folder" (no leading slash or tilde on the path).

# Breaking changes

* If you are already using the extension methods introduced in 3.2.0, you will need to reference them as static methods instead (I.E. `StreamExtensions.CopyStream(s)`, etc).
* The most commonly used extension methods (.Get<> and .Set<>) will continue working, as they were implemented in a base class.

[Continue reading changes made in alpha 0 release](/releases/3-2-alpha-0).