# Frequently asked questions

If you're getting an error message, [see the troubleshooting page instead](/docs/troubleshoot).

<dl class="faq">

  <dt>Q: How can I ensure only images with a command querystring incur additional processing?</dt><dd>A: You don't need to do anything; that's the default behavior.</dd>
	
	 <dt>Q: Is it possible to specify the width and height, and have your image resized and cropped to fit the aspect ratio, losing as little image area as possible? </dt> <dd>A: Yes, and it is easy. Use ?width=x&amp;height=y&amp;mode=crop.


</dd> <dt>Q: Are multi-page .TIFFs supported? </dt> <dd>A: Yes - you can convert any page of a multi-page .TIFF to .jpg, .png, or .gif. Use ?page=x&amp;format=jpg

</dd> <dt>Q: Can I resize the same image to different sizes? </dt> <dd>A: Yes - there is no limit on how many sizes of an image can be created.

</dd> <dt>Q: Is load balancing across multiple servers supported? </dt> <dd>A: Yes, and all plugins support web farms, web gardens, and load balancing.

</dd> <dt>Q: Do the image names change when they are resized? Is SEO affected? </dt> <dd>A: No, image names are retained - SEO isn't affected.

</dd> <dt>Q: If I resize a photo to its original size, will a new photo be returned, or the original? </dt> <dd>A: All photos are re-compressed, even if the original photo is the same size. This allows ICC correction, file size improvement, and metadata removal.

</dd> <dt>Q: Can the resizer both crop, then resize at the same time? </dt> <dd>A: Yes, you can specify a crop rectangle with ?crop=(x1,y1,x2,y2) or ?mode=crop, and add &amp;width=x or any of the resizing commands to resizing the resulting crop.
All commands can be combined.

</dd> <dt>Q: Can I use this on images not located on the server? </dt> <dd>A: Yes, with RemoteReader (Any HTTP server), S3Reader (Amazon S3 blobs), AzureReader (Azure blobs), MongoReader (GridFS) or  SqlReader (SQL blobs).
	
</dd> <dt>Q: When I resize a small image to larger dimensions, it stays at the original size. </dt> <dd>A: This is by design - add &amp;scale=both to allow images to be upscaled. You might want to consider up-scaling client-side to save bandwidth... Just set both width and height on the &lt;img&gt; tag. If you just want padding, use &amp;scale=canvas

</dd> <dt>Q: Can I use this with images stored in a database? </dt> <dd>A: Sure, with the SqlReader plugin. 

</dd> <dt>Q: Can I use this to resize images as users upload them? </dt> <dd>A: Sure! I suggest keeping the original images around, and using the resizer normally (in case you later want larger images).
However, it's easy to [resize during upload](/docs/howto/upload-and-resize).

</dd> <dt>Q: Is in necessary to wildcard map everything to ASP.NET when using IIS6? </dt> <dd>A: No - you can map .jpg, .png, and .gif individually, but <a href="http://support.microsoft.com/Default.aspx?kbid=909641">you need to follow this KB article</a> to prevent issues.

</dd> <dt>Q: I'm getting OutOfMemory exceptions when I try to resize certain large images for the first time (subsequent requests are fine). They're only 15MB in jpeg form, and I have 100MB of free RAM. </dt> <dd>A:
A 15MB JPG uncompresses to about 80MB in bitmap form (depending upon the compression level). If you are resizing to a 2MB jpeg (15MB BMP), memory requirements for the
operation are roughly 110MB (15 + 80 + 15). If you plan on using the resizer for very high-resolution photos (above 8MP), I suggest making sure you have ample amounts of RAM. 400MB to 1GB is usually plenty for the average web site with disk caching enabled.
</dd>
<dt>How do I auto-crop a certain distance or percentage away from an edge, instead of centering?</dt>
<dd>Manual cropping is applied before automatic cropping, so you can use that to crop the image before auto-cropping takes effect. To auto-crop against 10% away from the top of the image, use this: `crop=0,10,0,0&cropxunits=100&cropyunits=100&mode=crop&width=570&height=1500&anchor=topcenter`.</dd>

</dl>