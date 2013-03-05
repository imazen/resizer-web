# System Requirements

Check [out the high-level compatibility page first](/docs/workswith).

## Supported operating systems

Both 32 and 64-bit versions of Windows are supported. OS X and Linux can be used under the latest version of Mono, but individual plugin support may vary.

* Windows 2000
* Windows Server 2000
* Windows XP
* Windows Server 2003 (and R2)
* Windows Vista
* Windows Server 2008 (and R2)
* Windows 7

[WIC pipeline plugins](/plugins/wic) should only be used on Server 2008 R2 and Windows 7 or higher for optimal reliability. This restriction only applies to server-side ASP.NET applications - GUI or console applications can use the WIC plugins on XP and higher with impunity.

## Supported Windows web servers

One of the following web servers is required to host the image resizing server, although you can use any web server to host the actual application that calls it. For example, you could run both a Ruby server and IIS on the same machine, performing the image processing in IIS, but hosting the application in Ruby, Java, Python, or whichever modern language you prefer.
 
* IIS 5
* IIS 5.1
* IIS 6
* IIS 7 (both classic and integrated mode supported)
* IIS 7.5
* IIS Express
* Cassini, the Visual Studio Web Development Server (WebDev.exe).

## Supported .NET Framework versions

* .NET 2.0 SP2
* .NET 3.0
* .NET 3.5
* .NET 4.0
* .NET 4.5

## Plugins that require .NET 3.5 (these will not work in Windows 2000 or Windows Server 2000)

* BatchZipper
* PsdReader
* S3Reader
* Wic plugins
* ImageResizer.Mvc
* PdfRenderer
* PsdComposer
* MvcRoutingShim


## Samples that use .NET 3.5 and 4.0

* ConsoleApplication uses .NET 4.0
* ComplexWebApplication uses .NET 3.5
* ImageResizerGUI (WPF) uses .NET 4.0



Visual Studio 2010 is suggested for opening the sample projects and source code, although you can use 2008 if you rebuild the project files.

Visual Studio 2005 can be used to build the ImageResizer core project and many of the plugins. As before, you'll need to create a new project and add the existing code files into it.