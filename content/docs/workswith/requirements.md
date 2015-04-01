Aliases: /docs/requirements

# System Requirements

Check [out the high-level compatibility page first](/docs/workswith).

## Supported operating systems

Both 32 and 64-bit versions of Windows are supported. OS X and Linux can be used under the latest version of Mono, but individual plugin support may vary.

* Windows 2000 (v3 and below only)
* Windows Server 2000 (v3 and below only)
* Windows XP (v3 and below only)
* Windows Server 2003 (and R2) (v3 and below only)
* Windows Vista
* Windows Server 2008 (and R2)
* Windows 7
* Windows Server 2012
* Windows 8
* Windows 8.1


## Supported Windows web servers

One of the following web servers is required to host the image resizing server, although you can use any web server to host the actual application that calls it. For example, you could run both a Ruby server and IIS on the same machine, performing the image processing in IIS, but hosting the application in Ruby, Java, Python, or whichever modern language you prefer.
 
* IIS 5 (v3 and below only)
* IIS 5.1  (v3 and below only)
* IIS 6 (v3 and below only)
* IIS 7 (both classic and integrated mode supported)
* IIS 7.5
* IIS 8
* IIS 8.5
* IIS Express
* Cassini, the Visual Studio Web Development Server (WebDev.exe).

## Supported .NET Framework versions

* .NET 2.0 SP2 (v3 and below only)
* .NET 3.0  (v3 and below only)
* .NET 3.5 (v3 and below only)
* .NET 4.0 (v3 and below only)
* .NET 4.5
* .NET 4.6

## Plugins that require .NET 3.5 on v3

* BatchZipper
* PsdReader
* S3Reader
* Wic plugins
* ImageResizer.Mvc
* PdfRenderer
* PsdComposer
* MvcRoutingShim




Visual Studio 2012 is suggested for opening the sample projects and source code, although you can use 2008 if you rebuild the project files.

Visual Studio 2005 can be used to build the ImageResizer core project and many of the plugins. As before, you'll need to create a new project and add the existing code files into it.