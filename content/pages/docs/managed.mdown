
#Managed API usage

Most tasks with the managed API only require one line:

	ImageResizer.ImageBuilder.Current.Build(object source, object dest, ResizeSettings settings)
	
	or
	
	Bitmap b = ImageResizer.ImageBuilder.Current.Build(object source, ResizeSettings settings)

###object source

May be a physical path (C:\..), an app-relative virtual path (~/folder/image.jpg), an Image, Bitmap, Stream, VirtualFile, or HttpPostedFile instance. 

### object dest

May be a Stream instance, a physical path, or an app-relative virtual path.

###ResizeSetting settings

ResizeSettings is a friendly wrapper for a query string which provides named properties as well as the regular NameValueCollection interface.

You can create one like so:

	new ResizeSettings("maxwidth=200&maxheight=200")
	
	//or
	new ResizeSettings(Request.QueryString)
	
	//or
	var r = new ResizeSettings();
	r.MaxWidth = 200;
	r.MaxHeight = 300;
	


## Examples


	using ImageResizer;
	
	//Converts a jpeg into a png
	
	ImageBuilder.Current.Build("~/images/photo.jpg","~/images/photo.png", 
														 new ResizeSettings("format=png"));
	
	//Crops to a square (in place)
	ImageBuilder.Current.Build("~/images/photo.jpg","~/images/photo.jpg", 
														 new ResizeSettings("width=100&height=200&crop=auto"));
	
## Using variables in the destination path (3.1.3+)


Variables include the correct extension <ext>, random GUID <guid>, source path <path>, source filename <filename>, <width>, <height>, and any settings value <settings.*>. 

This makes many scenarios much easier to code, and reduces room for error. Many users make critical errors in their upload code, like not sanitizing filenames, or using the original extension (immediate server highjacking, here we go). 

With the new feature, a proper upload system is 3 lines:

ImageJob i = new ImageJob(file, 
"~/uploads/<guid>.<ext>", 
new ResizeSettings("width=1600")); 
i.CreateParentDirectory = true;
i.Build();

You can also filter values. <filename:A-Za-z0-9> keeps only the alphanumeric characters from the original filename.
