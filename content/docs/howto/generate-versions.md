# Generated resized versions of an image

While the ImageResizer shines at on-the-fly image processing, you can also use it to drastically simplify pre-processing and ahead-of-time resizing as well.

We strongly recommend using the dynamic method instead of pre-generating your images, as pre-generating versions reduces agility and flexibility.

In the examples below, only one line is required to perform all the image decoding, format conversion, processing, resizing, and re-encoding. The rest is path/filename logic.

Two different solutions are presented - 1 for processing images as they are uploaded, and another for processing images that are already saved to disk.

## 1. During upload

This method generates 3 versions of an image as it is uploaded, adding a \_thumb, \_medium, and \_large suffix to each filename. Uploaded files are named using a generated GUID, as uploaded file names are never safe for use as-is. Even with proper sanitization (alphanumeric filtering AND length limiting), you will encounter duplicates using uploaded filenames on your server.

	Dictionary<string, string> versions = new Dictionary<string, string>();
	//Define the versions to generate
	versions.Add("_thumb", "width=100&height=100&crop=auto&format=jpg"); //Crop to square thumbnail
	versions.Add("_medium", "maxwidth=400&maxheight=400&format=jpg"); //Fit inside 400x400 area, jpeg
	versions.Add("_large", "maxwidth=1900&maxheight=1900&format=jpg"); //Fit inside 1900x1200 area
	
	//Loop through each uploaded file
	foreach (string fileKey in HttpContext.Current.Request.Files.Keys) {
	    HttpPostedFile file = HttpContext.Current.Request.Files[fileKey];
	    if (file.ContentLength <= 0) continue; //Skip unused file controls.
			
	    //Get the physical path for the uploads folder and make sure it exists
	    string uploadFolder = MapPath("~/uploads");
	    if (!Directory.Exists(uploadFolder)) Directory.CreateDirectory(uploadFolder);
			
	    //Generate each version
	    foreach (string suffix in versions.Keys) {
	        //Generate a filename (GUIDs are best).
	        string fileName = Path.Combine(uploadFolder, System.Guid.NewGuid().ToString() + suffix);

	        //Let the image builder add the correct extension based on the output file type
	        fileName = ImageBuilder.Current.Build(file, fileName, new ResizeSettings(versions[suffix]), false, true);
	    }
			
	}


## 2. After upload

This example method generates 3 versions of the specified file, and returns a list of the final path names.

For example,

	GenerateVersions("~/images/image.jpg")

Will generate

	/images/image\_thumb.jpg
	/images/image\_medium.jpg
	/images/image\_large.jpg

And will return a list of those paths.


	public IList<string> GenerateVersions(string original) {
			Dictionary<string, string> versions = new Dictionary<string, string>();
			//Define the versions to generate and their filename suffixes.
			versions.Add("_thumb", "width=100&height=100&crop=auto&format=jpg"); //Crop to square thumbnail
			versions.Add("_medium", "maxwidth=400&maxheight=400format=jpg"); //Fit inside 400x400 area, jpeg
			versions.Add("_large", "maxwidth=1900&maxheight=1900&format=jpg"); //Fit inside 1900x1200 area


			string basePath = ImageResizer.Util.PathUtils.RemoveExtension(original);

			//To store the list of generated paths
			List<string> generatedFiles = new List<string>();

			//Generate each version
			foreach (string suffix in versions.Keys)
					//Let the image builder add the correct extension based on the output file type
					generatedFiles.Add(ImageBuilder.Current.Build(original, basePath + suffix, 
						new ResizeSettings(versions[suffix]), false, true));

			return generatedFiles;	 
	}
