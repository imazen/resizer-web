Date: June 4 2012
FullFile: http://downloads.imageresizing.net/Resizer3-2-alpha-1-full-Jun-4-2012.zip
MinFile: http://downloads.imageresizing.net/Resizer3-2-alpha-1-min-Jun-4-2012.zip
Summary: 1 bug fix
ShortVersion: 3.2.1

# Resizer 3.2 alpha 1 - June 4 2012

This is an **alpha** release.


Version 3.2 underwent heavy refactoring. Hundreds of changes were made to more than 258 code files. While the changes were quadruple-checked, there may still be some bugs. 
Be the first to report a given bug to support@imageresizing.net and claim the bounty! The best place to look for bugs is probably in querystring parsing, or the newly added Instructions class.

**NuGet users: The latest ImageResizer.WebConfig package may insert a duplicate element in Web.config when you upgrade. Simply delete the one that doesn't include `requirePermission="false"`.**

	<section name="resizer" type="ImageResizer.ResizerSection"/>
	<section name="resizer" type="ImageResizer.ResizerSection" requirePermission="false"/>

# Bug fixes in 3.2.1

* Eliminated ExtensionAttribute-related compile-time warnings (C#) and errors (VB) for, uh, *most* users. 

If you still experience any ExtensionAttribute-related problems, see [ my StackOverflow answer for a list of workarounds](http://stackoverflow.com/a/10996336/166893).

If that doesn't resolve the problem, please e-mail a .zip file of the project to `support@imageresizing.net`, and include your VisualStudio/.NET version numbers (Go to Visual Studio, Help, About, and click `Copy Info`, then paste it into the e-mail). 

[Continue reading changes made in alpha 0 release](/releases/3-2-alpha-0).