Date: June 30 2012
FullFile: http://downloads.imageresizing.net/Resizer3-2-beta-3-full-Jun-30-2012.zip
MinFile: http://downloads.imageresizing.net/Resizer3-2-beta-3-min-Jun-30-2012.zip
Summary: 4 bug fixes
ShortVersion: 3.2.3
Layout: release
Libs: plusone
Tags: releases

# Resizer 3.2 beta 3 - June 30 2012

This is an beta release: Version 3.2 underwent heavy refactoring. Hundreds of changes were made to more than 258 code files. While the changes were quadruple-checked, there may still be some bugs. 
Be the first to report a given bug to support@imageresizing.net and claim the bounty! The best place to look for bugs is probably in querystring parsing, or the newly added Instructions class.

**NuGet users: The latest ImageResizer.WebConfig package may insert a duplicate element in Web.config when you upgrade. Simply delete the one that doesn't include `requirePermission="false"`.**

	<section name="resizer" type="ImageResizer.ResizerSection"/>
	<section name="resizer" type="ImageResizer.ResizerSection" requirePermission="false"/>

# Bug fixes in 3.2.3

* Fixed false positive warning "An external process indicates it is managing cleanup..." on diagnostics page
* Added support for multi-page .TIFF files that have pages of different dimensions.
* VirtualFolder now works when vpp="false" and for UNC paths.
* Improved support for Rackspace Cloud (eliminated NativeDependencyManager-related issues).

# Improvements in 3.2.3

* Added support for VirtualPathProviders that return IVirtualFile compliant VirtualFile instances, but do not implement IVirtualImageProvider
* [Ben Foster](http://ben.onfabrik.com/) contributed a small plugin that makes it easier to configure which file extensions ImageResizer intercepts. This can be useful if you're not using standard image extensions, or need .ico support, etc. You can find the plugin in Contrib\AdditionalFileExtensionsPlugin

[Continue reading changes made in V3.2.0 release](/releases/3-2-alpha-0).






