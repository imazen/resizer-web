#A list of some *Really Bad Ideas*:

* **Not installing the MvcRoutingShim on an ASP.NET project that uses Routing**. Of course nothing is going to work right when 2 HttpModules are both trying to answer the same request.
* **Implementing your own disk caching system**. Disk caching is not an IF statement. If you think you can do a secure implementation in under 5KLOC, you don't understand the problem space.
* **Wrapping the managed API in an ActionResult or custom HttpHandler**. MVC is cool stuff. But like ALL OTHER FRAMEWORKS, it is [**very** bad at serving static files or doing image processing](/docs/mvc). It's designed for HTML, XML, and JSON. There are several dozen very good reasons why you need an HttpModule for this kind of stuff. HttpHandlers and ActionResults are both inherently terrible at static file serving and disk cached processing.
* **Batch processing images inside a request thread**. If you possibly can, give each image a separate request so it has a chance at succeeding in bad conditions. 
* **Trying to batch process multiple images inside a request thread in parallel**. A single image can require 50-200MB of RAM to process. And you want to do them 50 at a time? It's wasteful and will actually take longer. This is not client side development; throughput and stability trumps theoretical response time. 
* **Touching any System.Drawing class directly from a server app**. It's just plain dumb unless you come from a heavy Win C++ background. 95% of all server-side memory leaks occur this way.
* **Re-using the original filename (or extension) of an image upload when saving it to disk. That's instant root access for any elementary school kid who notices.** 
* **Building your own SQL/S3/Azure/GridFS/RemoteURL -> Managed API bridge instead of using the existing datastore plugins**. Nothing is simple when you're dealing with images of arbitrary size and format, not even a basic SQL call. 

I've made [a plugin](/plugins) for nearly every situation, and they're [easy to make yourself](/docs/plugins/basics) as well. 

And, if all else fails, [try reading the docs](/docs) or [searching the site](/search).
