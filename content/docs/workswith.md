# Known to work with

For information about operating system, web server, and .NET framework compatibility, see [the system requirements page](/docs/requirements).

## Content management systems

There are no known CMSes that are incompatible with the image resizer HttpModule. If you do encounter any compatibility issue, please report it.

The following have been reported to work successfully.

* DotNetNuke
* Umbraco ([Example by heltBlank](http://heltblank.wordpress.com/2012/02/13/imageresizing-net-and-umbraco-5-jupiter/))
* Sitefinity CMS
* [Orchard (see notes and examples)](/docs/workswith/orchard)
* Sitecore (Blocks .ashx - either use a different extension or switch to IIS7+ Integrated Mode )
* Wordpress (Requires IIS or Mono and a bit of extra work)
* [EPiServer](http://www.frederikvig.com/2013/01/add-powerful-image-resizing-cropping-and-manipulation-support-to-your-episerver-website/)

In addition, the ImageResizer has been directly integrated into 20-30 lesser-known CMSes.

## Datastores

* Amazon S3 (Via [S3Reader plugin](/plugins/s3reader))
* MongoDB GridFS (Via [MongoReader plugin](/plugins/mongoreader))
* Microsoft SQL (via [SQLReader plugin](/plugins/sqlreader))
* Microsoft Azure Blob storage (via [AzureReader plugin](/plugins/azurereader))
* Rackspace Cloud Files (Via [RemoteReader plugin](/plugins/remotereader))
* Anything accessible over HTTP  (Via  [RemoteReader plugin](/plugins/remotereader))

At this time, there are no known datastores that are incompatible with the image resizer, although some may require a plugin to access. If you have a datastore not listed here, [read about custom plugin development](/plugins/custom)


## CDN

* Amazon CloudFront (with the CloudFront plugin)
* Azure CDN (no plugin needed if you configure it to preserve querystrings)
* Any CDN that supports custom-origin. The CloudFront plugin may be required for any CDN that strips off querystrings

Any pull-based CDN should work perfectly with the image resizer. Push-based CDNs like RackSpace work contrary to the on-demand nature of the ImageResizer. While you can use them, it will require additional coding and you'll have to decide which sizes will be available up-front.

## Hosting providers

Any hosting provider will work, but many restrict ASP.NET permissions to the point where some external plugins can't run. Others just restrict (or don't provide enough) bandwidth, making image serving unbearably slow. 

Here's a few I've worked with.

* DiscountASP (100% compatible, but limited download bandwidth speed)
* MaximumASP (100% compatible, great company, great support)
* WebHost4Life (100% compatible,  but *very* limited download bandwidth speed. You must make support enable wildcard mapping, you can't do it through the control panel)
* RackSpace (RackSpace enforces very strict and highly erratic customized trust levels that can disable most plugins. However, some plans allow for full trust or allow you to fix their medium trust configuration. If you're getting a dedicated or virtual server, you'll probably be fine). If you're already stuck with RackSpace, I can still help you make the best of the situation, just contact support@imageresizing.net.
* Amazon EC2 (100% compatible, my personal choice)

I've also had success stories about dozens of other ISPs from hundreds of users. 

If your provider doesn't allow Full Trust, you may not be able to run the PrettyGifs plugin or some of the advanced plugins in the Creative edition, but all the core functionality should work fine. The Watermark and SimpleFilters will even work in low trust, so the Creative edition can still be useful in that situation.

So far, I've been able to resolve every ISP-related compatibility problem I've been notified of, with the exception of certain external plugins that intrinsically require full trust.


## Image formats (by default)

* Jpeg
* Png
* Gif
* Bmp
* Wmf
* Emf

## Image Formats (With FreeImageBuilder or FreeImageDecoder plugin)

* RW/CR2, NEF, RAF, DNG, MOS, KDC, DCR, etc. Also introduced support for XBM, XPM, TARGA, SGI, Sun RAS, PSD, PICT, PNG, PFM, PBM, PGM, PPM, PCX, MNG, Kodak PhotoCD, KOALA, JPEG-2000, JIF, JNG, IFF, ICO, Raw Fax G3, EXR, DDS, and Dr. Halo CUT

## Image Formats (With WicBuilder or WicDecoder)

* Any image formats you can view in Windows Explorer - installed codecs are used.


