
# ASP.NET MVC

The ImageResizer is fully MVC (1-4) compatible, however, some routes may conflict with the ImageResizer URLs. 

To resolve these conflicts, simply install the [MvcRoutingShim](/plugins/mvcroutingshim) plugin. The MvcRoutingShim plugin prevents routes from messing with a request that is already being processed by the ImageResizer. 

## Use the URL API, DON'T WRAP THE MANAGED API IN AN ACTIONRESULT!

Yes, the use of all caps and the exclamation mark *is* justified here. Although using an ActionResult won't cause a memory leak (unless you directly interact with System.Drawing), it *will* prevent any kind of disk caching, and keep you from being able to handle more than a handful of concurrent visitors at a time. 

An unfortunate limitation of ASP.NET MVC is that it doesn't allow efficient disk caching. Actions are executed too late to allow continuation on a native IIS thread. **This isn't a fault in the ImageResizer, it's a flaw in ASP.NET MVC**. The URL API is implemented as an MVC-friendly HttpModule, so it isn't affected. But if you write your own routes and ActionResults(s) to wrap the managed API instead of using the URL API, you're going to see terrible performance and scalability, and you won't be able to do disk caching. For more detailed information, [listen to the Hanselminutes podcast on the topic (feat. Scott Hansleman and I)](http://www.hanselminutes.com/313/deep-inside-image-resizing-and-scaling-with-aspnet-and-iis-with-imageresizingnet-author-na) and read the [less-detailed article that lead to it](http://www.hanselman.com/blog/BackToBasicsDynamicImageGenerationASPNETControllersRoutingIHttpHandlersAndRunAllManagedModulesForAllRequests.aspx).

The URL API avoids the problem by handling processing during the PostAuthorizeRequest stage. To take advantage of this, though, you need to use the `Config.Current.Pipeline.Rewrite` event if you want to use your 'own' URL syntax, perform DB lookups, or custom logic. The `Rewrite` event is much more capable than an ASP.NET route, so anything you can do with a route you can do with the `Rewrite` event. It can also be simpler.

Here's an example `Rewrite` handler that forces all images within the "~/folder/" to be resized to a width of 100 pixels. Pretty straightforward.

	Config.Current.Pipeline.Rewrite += delegate(IHttpModule sender, HttpContext context, IUrlEventArgs ev) {
	    if (ev.VirtualPath.StartsWith(VirtualPathUtility.ToAbsolute("~/folder/"), StringComparison.OrdinalIgnoreCase))
	        ev.QueryString["width"] = "100";
	};

## We support your data store already, don't invent a square wheel

The ImageResizer offers URL-based access to S3 (with [S3Reader](/plugins/s3reader)), MS SQL (with [SqlReader](/plugins/sqlreader)), Azure Blob Storage (with [AzureReader](/plugins/azurereader)), MongoDB GridFS (with [MongoReader](/plugins/mongoreader)), arbitrary HTTP-accessible files (through [RemoteReader](/plugins/remotereader)), physical files, or virtual files. 

If you need to access files from some other kind of data store, you'll need to make a [plugin with 4 methods](/docs/plugins/virtualimageprovider). It's not hard to make your own image provider, and it will allow disk caching to work properly.
