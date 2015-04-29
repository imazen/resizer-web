Title: Plugin Bundles - Image Resizer
Libs: uservoice, -comments
Warning: Bundles were discontinued on Feb. 1 2013 in favor of a simplified product model.
Aliases: /plugins/bundles/1 /plugins/bundles/2 /plugins/bundles/3 /plugins/bundles/4  /plugins/bundles


# Plugin Bundles

All bundles were discontinued on Feb. 1 2013 in favor of a simplified product model. This information is provided for reference purposes. Only ImageResizer v3 was offered under these SKUs. All bundles were priced the same, $249 for an enterprise-wide license. For a short time, $99 personal use licenses were offered, but they were almost exclusively purchased by large companies, and the SKU was discontinued.

Note that bundles were not overlapping, but rather a-la-carte. 


## Performance Bundle


The Performance bundle costs $249 for an enterprise-wide license, or $99 for a personal license. 
 
Included:

* DiskCache plugin - Makes dynamic image processing as responsive and scalable as static images - because they are! Suggested, nay, required for websites with significant traffic.
* AnimatedGifs plugin - Process and resize GIF animations like normal GIF images. Every frame is processed and re-encoded.
* PrettyGifs plugin - Get rid of ugly .NET GIFs, and get photoshop-like results for GIFs and 8-bit PNG images. Uses tuned octree quantization and smart, adjustable dithering.


## Design bundle

Features:

- Get a 2-4x speed boost by using WIC instead of GDI (requires full trust)
- Go nuts with your RAW files, PSD files, and apply advanced filters you'd only expect from Photoshop.
- Overlay (or underlay) multiple text and image layers with the Watermark plugin - anything is possible.
- Auto-trim your product photos with WhitespaceTrimmer, or use SeamCarving to magically change the aspect ratio of images by slicing seams of pixels from background (low-energy) areas of the image.

Included:

* SeamCarving plugin - Content-aware image resizing (Fast C++ exe, requires Full Trust)
* New Watermark plugin (v3.1+) - Render multiple image & text overlays and background layers with incredible flexibility and great performance.
* WIC Plugins (V3.1+) - 3 plugins: WicDecoder supports decoding images through WIC, supporting any image codecs installed on the computer. WicEncoder encodes jpeg, gif, and png images through WIC for better performance and more control. Adjust jpeg quality, subsampling, gif dithering, and palette size. WicBuilder provides a completely alternate pipeline, which supports most basic resize/crop/pad operations. 2-4x faster than the default pipeline. Enable on a per-request bass.
* FreeImage Plugins - Includes 4 plugins: FreeImageDecoder adds support for RAW & HDR source images - over 20 formats supported. FreeImageEcoder provides 2-4x Faster jpeg encoding. FreeImageResizer adds support for Lanczos3 and CatmullRom scaling. FreeImageBuilder provides an alternate imaging pipeline.
* PsdReader plugin - Adds support for PSD source files.
* SimpleFilters plugin - Adjust photo transparency, brightness, and apply sepia and B&amp;W filters through the querystring. Nearly zero performance overhead - matrix-based.
* AdvancedFilters plugin - Blur, sharpen, remove noise, and perform automatic histogram adjustment. Plus several other cool effects.
* WhitespaceTrimmer plugin - Automatically trims whitespace off an image using smart edge detection


##  Cloud Bundle

Resize images (or serve files) from remote websites, Amazon S3 buckets, Azure Blob Storage, MongoDB GridFS, or Microsoft SQL. Integrate your website with Amazon's CloudFront CDN in seconds for unbeatable performance worldwide. All plugins are medium-trust compatible.

See [Cloud Basics](/docs/cloud) for the overview.

Included: 

* MongoReader plugin - Allows GridFS files to be resized and served
* CloudFront plugin - Allows you to use Amazon CloudFront with the resizer. Highly recommended - offers inexpensive worldwide edge caching and great scalability.
* AzureReader plugin - Allows blobstore images to be resized and served. (Azure 1.X compatible)
* SQLReader plugin - Process and resize images located in a MS SQL database. Extremely configurable, can work with nearly any database schema. A VirtualPathProvider.
* S3Reader plugin - Process and resize images located on a remote Amazon S3 bucket. A VirtualPathProvider. Works best when combined with DiskCache.
* S3Reader2 plugin - Process and resize images located on a remote Amazon S3 bucket. A VirtualPathProvider. Works best when combined with DiskCache.
* RemoteReader plugin - Allows images located on external servers to be securely resized and processed as if they existed locally.
* AzureReader2 plugin - Allows blobstore images to be resized and served. (Azure 2.0 compatible)

##  Extras Bundle

* PsdComposer - Dynamically edit and render PSD files - turn layers on and off, edit text layer contents, and apply certain effects.
* BatchZipper plugin - Asynchronously generated .zip archives of files and resized images. Great for providing customized downloads to customers.
