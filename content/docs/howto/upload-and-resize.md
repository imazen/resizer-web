
# How to resize images as they are uploaded

Resizing and processing images as they are uploaded is very straightforward. Most of the required code is about paths and directories.

The following sample code generates a GUID filename for each upload, determines the appropriate file extension that is needed, then resizes/crops/formats the image according to the specified ResizeSettings.

	//Loop through each uploaded file
	foreach (string fileKey in HttpContext.Current.Request.Files.Keys) 
	{
		HttpPostedFile file = HttpContext.Current.Request.Files[fileKey];
		if (file.ContentLength <= 0) continue; //Skip unused file controls.
		
		//The resizing settings can specify any of 30 commands. See http://imageresizing.net for details.
		//Destination paths can have variables like <guid> and <ext>, or 
		//even a santizied version of the original filename, like <filename:A-Za-z0-9>
		ImageResizer.ImageJob i = new ImageResizer.ImageJob(file, "~/uploads/<guid>.<ext>", new ImageResizer.ResizeSettings( 
								"width=2000;height=2000;format=jpg;mode=max"));
		i.CreateParentDirectory = true; //Auto-create the uploads directory.
		i.Build();
	}



## For VB.NET users

	'Loop through each uploaded file
	For Each fileKey As String In HttpContext.Current.Request.Files.Keys
			Dim file As HttpPostedFile = HttpContext.Current.Request.Files(fileKey)
			If (file.ContentLength > 0) Then 'Skip unused file controls.
				'The resizing settings can specify any of 30 commands. See http://imageresizing.net for details.
				'Destination paths can have variables like <guid> and <ext>, or 
				'even a santizied version of the original filename, like <filename:A-Za-z0-9>
				Dim i As ImageResizer.ImageJob = New ImageResizer.ImageJob(file, "~/uploads/<guid>.<ext>", New ImageResizer.ResizeSettings("width=2000;height=2000;format=jpg;mode=max"))
				i.CreateParentDirectory = True 'Auto-create the uploads directory.
				i.Build()
			End If
	Next
