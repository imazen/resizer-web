# Frequently Asked Questions

##General

Why do I get an error message whenever I...
: If you're getting an error message, [see the troubleshooting page instead](/docs/troubleshoot).

How can I ensure only images with a command querystring incur additional processing?
: You don't need to do anything; that's the default behavior.

Are multi-page .TIFFs supported?
: Yes - you can convert any page of a multi-page .TIFF to .jpg, .png, or .gif. Use ?page=x&amp;format=jpg

Is load balancing across multiple servers supported?
: Yes, and all plugins support web farms, web gardens, and load balancing.

Do the image names change when they are resized? Is SEO affected? 
: No, image names are retained - SEO isn't affected.

Is it necessary to wildcard map everything to ASP.NET when using IIS6?
: No - you can map .jpg, .png, and .gif individually, but [you need to follow this KB article](http://support.microsoft.com/Default.aspx?kbid=909641) to prevent issues.

I'm getting OutOfMemory exceptions when I try to resize certain large images for the first time (subsequent requests are fine). They're only 15MB in jpeg form, and I have 100MB of free RAM.
: A 15MB JPG uncompresses to about 80MB in bitmap form (depending upon the compression level). If you are resizing to a 2MB jpeg (15MB BMP), memory requirements for the operation are roughly 110MB (15 + 80 + 15). If you plan on using the resizer for very high-resolution photos (above 8MP), I suggest making sure you have ample amounts of RAM. 400MB to 1GB is usually plenty for the average web site with disk caching enabled.

##Resizing Tasks

How do I auto-crop a certain distance or percentage away from an edge, instead of centering?
: Manual cropping is applied before automatic cropping, so you can use that to crop the image before auto-cropping takes effect. To auto-crop against 10% away from the top of the image, use this: `crop=0,10,0,0&cropxunits=100&cropyunits=100&mode=crop&width=570&height=1500&anchor=topcenter`.

Can I resize the same image to different sizes?
: Yes - there is no limit on how many sizes of an image can be created.

Is it possible to specify the width and height, and have your image resized and cropped to fit the aspect ratio, losing as little image area as possible?
: Yes, and it is easy. Use ?width=x&amp;height=y&amp;mode=crop.

If I resize a photo to its original size, will a new photo be returned, or the original?
: All photos are re-compressed, even if the original photo is the same size. This allows ICC correction, file size improvement, and metadata removal.

Can the resizer both crop, then resize at the same time? 
: Yes, you can specify a crop rectangle with ?crop=(x1,y1,x2,y2) or ?mode=crop, and add &amp;width=x or any of the resizing commands to resizing the resulting crop. All commands can be combined.

When I resize a small image to larger dimensions, it stays at the original size. 
: This is by design - add &amp;scale=both to allow images to be upscaled. You might want to consider up-scaling client-side to save bandwidth. Just set both width and height on the &lt;img&gt; tag. If you just want padding, use &amp;scale=canvas

##Image Sources

Can I use this on images not located on the server? 
: Yes, with RemoteReader (Any HTTP server), S3Reader (Amazon S3 blobs), AzureReader (Azure blobs), MongoReader (GridFS) or  SqlReader (SQL blobs).

Can I use this with images stored in a database? 
: Sure, with the SqlReader plugin. 

Can I use this to resize images as users upload them? 
: Sure! I suggest keeping the original images around, and using the resizer normally (in case you later want larger images).
However, it's easy to [resize during upload](/docs/howto/upload-and-resize).

##Licensing and Payment {#licensing}

Is the fee annual or one-time?
: Our license fee is a one-time payment. Buy it once and you have that version for life. Our support contracts include permanent licenses as well, however, support benefits and free upgrades are limited to the contract duration.

Is there some kind of trial license for ImageResizer?
: Yes! Simply download ImageResizer on the download page. Until something is put into production, there's no need to pay or do anything else. You can find out more about it [here](/licenses/trial).

Can I buy plugins individually?
: No — they're designed to work together. We only sell plugins in 3 groups, each a superset of the last: Performance, Creative, and Elite.

My company designs custom websites for other companies, and I want a license plan that allows me to make ImageResizer a part of the package to my clients. Which license should I use?
: The [Elite license](/licenses/enterprise) is probably best for your situation. Your customers can get a free [Client license](http://imageresizing.net/licenses/proclient) with any bespoke software you develop for them.

I want to redistribute ImageResizer Essential Edition as part of another project. Do I need to pay anything?
: No - the [19 plugins in the Essential edition](http://imageresizing.net/plugins/editions/free) are provided under the [Freedom license](http://imageresizing.net/licenses/freedom), which permites redistribution similar to the MIT license. Check your diagnostics page to verify you're not using any paid plugins.

I want to redistribute ImageResizer Performance, Creative, or Elite Edition plugins as part of another product or project. What license do I need?
: You will need to contact us to get an [OEM license](http://imageresizing.net/licenses/oem) appropriate for your needs. 

How can I get a feature covered in this lower-level license in my higher-level license?
: Every higher level of licensing includes all of the features of all previous licenses. So, everything in the Performance license is included in the Creative, Elite, and Support Contracts.

I've previously purchased a Performance Edition license, but I would like to upgrade to a Creative License. Do I have to buy the new one entirely, or can I get a discount?
: Unfortunately, we cannot modify an existing offline license key once it is issued, nor can we offer a discount on any new purchase of a higher or lower-level license.



