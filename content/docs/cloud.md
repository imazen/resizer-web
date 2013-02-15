Layout: install_page

# Cloud basics

![ImageResizer Cloud](https://s3.amazonaws.com/resizer-web/Resizer-Cloud.png)

ImageResizer is compatible with every cloud offering, but some self-proclaimed CDNs do not support origin servers. Stay away from them! Real CDNs can pull, not only accept pushes.

For the best performance, pick a cloud that offers all 3 services within the same datacenter. Low latency between blob storage and the server(s) hosting ImageResizer is very important.

1. High-speed blob storage (like Amazon S3 or Azure Blob Storage)
2. ASP.NET hosting (IIS or mono). AppHarbor is the easiest and least expensive I've found, and is also AWS hosted for fast S3 access.
3. A CDN/edge caching solution that acts as a reverse proxy. This means *pull* **not** *push*. _Rackspace does not offer this._ Their CDN cannot pull from a server, only from CloudFiles. They proudly state they use Akami hardware, but they do NOT support custom-origin as the *real* Akami and CloudFront CDNs do. I personally use CloudFront and pay $2-$3/mo.

Once you've selected a cloud, you'll need to follow this general outline of steps:

1. Set up a container or bucket in your blob storage service and upload some test files to it. 
2. Install ImageResizer and the appropriate plugins on the ASP.NET site. You'll need [S3Reader](/plugins/s3reader), [AzureReader](/plugins/azurereader), [MongoReader](/plugins/mongoreader), or [RemoteReader (for generic HTTP access)](/plugins/remotereader) to access the cloud-stored files. You may also need the [CloudFront plugin if your CDN strips query strings](/plugins/cloudfront). Many CDNs are now configurable about this - but if you can't convince your CDN to leave the querystring alone, you'll have to switch to the semicolon syntax supported by the CloudFront plugin to avoid it (No, the CloudFront plugin is not Amazon-specific).
3. (Optional) Set up rewrite rules to customize your URLs. Some people dislike the /s3/bucket/filename.ext syntax - this is your chance to change it. In App_Start, add a handler to Config.Current.Rewrite and modify e.VirtualPath and e.Querystring separately. 
4. Create your CDN distribution. The process is very similar for both Amazon CloudFront and Azure CDN - provide the origin server's DNS name (this must point to the server or load balancer running the ImageResizer), then specify a list of CNAMES, the friendly DNS names you want to appear in your final URLs.
5. Go to your DNS manager and set up those CNAMES to point to the DNS name provided by the CDN. (hopefully you're using a sane service like [NameCheap](http://namecheap.com) instead of the nightmare of broken code and failed DNS updates that is GoDaddy...)
6. Configure CDN cache durations at the CDN level or through the [ClientCache](/plugins/clientcache) plugin.

### Request flow

You cannot point the CDN (Ex. CloudFront or Azure CDN) directly to blob storage. This won't work, because ImageResizer has no chance to be involved in the process. I get this question twice a week!

The flow is thus

1. Your website has an image URL on a page. The URL points to the CDN either via a direct DNS name or through a vanity CNAME.
2. The visitor's browser requests that URL.
3. Amazon CloudFront or Azure CDN receive the request. If the file has been requested before in this region, it is sent back to the browser immediately with extremely low latency. 
4. If there is a cache miss, the request is forward on to the *Origin Server*, which runs ImageResizer. 
5. If ImageResizer has the DiskCache plugin installed, the request is served from disk if present. 
6. If [DiskCache](/plugins/diskcache) is not installed, or if the file has never been requested before by *any* endpoint, the source file will be accessed, processed, encoded, and returned to the CDN, which will cache it and serve it to the browser.
7. In the case of a cache miss at the output layer, the source file may still be cached locally with SourceMemCache or SourceDiskCache (not yet released). 
8. If there is a cache miss on the source file, an HTTP(s) request will be made to Azure/S3/Mongo/etc to download the source file into memory (and potentially cache it), process it, disk cache it (if installed), and send it back to the CDN, which will send it back to the browser.

Multi-level caching is important. The CDNs ensures only a fixed amount of requests for each URL will hit the ImageResizer, but that number can still be high if your users are widely distributed across the globe. If you have 100+ CDN endpoints, that means you can still have (endpoints) requests per (expires-duration) duplicate requests hit the server. Also, CDNs often delete infrequently used files, so if you're a 'small player', you may not be cached for the entire duration of the 'expires' header.


### Scaling tips

1. Use a load balancer or a managed service like AppHarbor to ensure you can scale quickly in response to changing traffic conditions. Point your CDN to this instead of to a single instance, so you can ramp up easily.
2. Use Git & GitHub for your code, Web.config, and ImageResizer dlls, so you can auto-deploy to all your instances in seconds.
3. Use GUIDs for filenames. Don't use custom time or counter-based IDs, you'll encounter duplicates any time you have simultaneous uploads

### Maintenance tips

1. Have a central URL generator so you can modify your front-facing URLs quickly in case you need to implement or switch CDNs. 
2. Design for immutability. URLs should always return the same image. This eliminates caching nightmares and allows you to enable 'fastMode' on your S3/Azure/SQL readers.
3. Again, don't allow blobs to be edited. Create a new blob. 





