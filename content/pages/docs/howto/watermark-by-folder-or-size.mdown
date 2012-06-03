
# How to require a watermark by folder or image size

The *PostRewrite* event is the last of the URL rewriting events, and can be used to enforce certain settings.

You can add an event handler during the Application\Start method in Global.asax.cs.

The following sample code applies a watermark to all images inside 'folder' that are probably above 100x100. I say probably, because the size estimation is based on the assumption that the original image is a 600x600 square. Given a 600x100 actual image size and the querystring "?height=99", the image could escape watermarking and display at 594x99.

So, with this code, you can only know that *one* of the dimensions will be less than 100px - you can't know that both will be.

	Config.Current.Pipeline.PostRewrite += delegate(IHttpModule sender, HttpContext context, IUrlEventArgs ev) {
	    //Check folder
	    string folder = VirtualPathUtility.ToAbsolute("~/folder");
	    if (ev.VirtualPath.StartsWith(folder, StringComparison.OrdinalIgnoreCase)) {
	        //Estimate final image size, based on the original image being 600x600. 
	        Size estimatedSize = ImageBuilder.Current.GetFinalSize(new System.Drawing.Size(600,600),
							new ResizeSettings(ev.QueryString));
	        if (estimatedSize.Width > 100 || estimatedSize.Height > 100){
	            //It's over 100px, apply watermark
	            ev.QueryString["watermark"] = "Sun_256.png";
	        }
	    }
	};

## Important note

While the above enforces watermarking on all processed images, the `process=no` command can disable processing of the image completely, avoiding all resizing and watermarking.

To prevent this, you should add some more code inside PostRewrite

	Config.Current.Pipeline.PostRewrite += delegate(IHttpModule sender, HttpContext context, IUrlEventArgs ev) {
			//Check folder
			string folder = VirtualPathUtility.ToAbsolute("~/folder");
			if (ev.VirtualPath.StartsWith(folder, StringComparison.OrdinalIgnoreCase)) {
					//Estimate final image size, based on the original image being 600x600.
					Size estimatedSize = ImageBuilder.Current.GetFinalSize(new System.Drawing.Size(600,600),
													new ResizeSettings(ev.QueryString));
					if (estimatedSize.Width > 100 || estimatedSize.Height > 100){
							//It's over 100px, apply watermark
							ev.QueryString["watermark"] = "Sun_256.png";
							//Force processing if it's an image
							if (Config.Current.Pipeline.IsAcceptedImageType(ev.VirtualPath))
								ev.QueryString["process"] = "Always";
					}
			}
	};

