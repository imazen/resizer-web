Flags: hidden

# Responsive Image Uploading App in MVC 4, Part 1 of 4

## Summary

Learn why responsive images is a good idea and how to implement it in MVC 4 for Visual Studio. You will learn how to upload images to Amazon S3 and serve them with Imazen ImageResizer. You will then take this barebones site and make it responsive and look polished by using Zurb Foundation 4 with Sass for MVC 4. 

You will then learn how to implement responsive images with Interchange and Imazen's Slimmage. At the end of the article you will see some hard data and learn about some advanced features available with Imazen ImageResizer.

## Prerequisites

You should have completed the following or be familiar with the following technologies and tools to easily follow this tutorial:

* Microsoft Visual Studio 2013
     + [Mindscape Web Workbench](http://www.mindscapehq.com/products/web-workbench)
     + [NuGet Package Manager](http://www.nuget.org/)
* AWS (Amazon Web Services) S3 Account
* Basic knowledge of C# .NET MVC 4, HTML, Sass/SCSS and JavaScript
* Familiar with Grid Systems and Responsive Web Design concepts

## Table of Contents

### Part 1

* Why Responsive Images, why do this?
* File Bloat on the Web Today
* Simple Image Uploading in MVC 4 to AWS S3

### Part 2
Zurbifying your App with Zurb Foundation 4 MVC

### Part 3
Responsive Images with Interchange and Imazen Slimmage.js

### Part 4
Results and Advanced Features

> If you get lost along the way, don't worry. We have all the code uploaded into a github repo with specific branches so you can check your progress or jump to the code at any time.

## File Bloat on the Web Today

File bloat is a big problem on the web today. Todays websites are getting larger and the trend doesn't seem to be going away anytime soon. This can be largely blamed on sites catering to higher density displays and everything-and-the-sink web framework css and javascript bloat.

Although it is generally a good idea to provide these higher pixel denisity display devices a good UX it should not and does not have to be at the expense of everyone else using your site or app.

Repsonsive images is a great way to lower the overhead of your site by providing various resolutions of the same image depending on the device it is viewed on. This way you can you provide a small low res jpeg with better quality to your mobile users and large high res jpegs with lower quality to those with the higher pixel displays.

There are a couple of ways to accomplish this and generally they use media queries to define which images are served. We will look at Zurb Interchange, the built in Zurb Foundation option as well as Slimmage.js from Imazen.

If you use either library or roll your own solution Image Resizer provides a just in time, cached, scalable, stable and enterprise ready solution that is easy to implement.

## AWS S3 Uploads in C# MVC 4

The first thing we will want to do is to create a model that will handle our image information. Since we will be storing the image on s3, we just need a `public string` tha will call `ImageURL` where we will store the location in our AWS S3 Bucket.

Models/Photos.cs ( [view on github](), [raw]() ) :

	using System;
	using System.Collections.Generic;
	using System.Linq;
	using System.Web;

	namespace SimpleMVCUpload.Models
	{
	    public class Photo
	    {
	        public int ID { get; set; }
	        public string ImageURL { get; set; }
	        public string Caption { get; set; }
	        public DateTime UploadDate { get; set; }
	        public int Rank { get; set; }

	    }
	}

Before we generate our Controllers and Views we need to install and add the AWS SDK to the current project. Using the NuGet Package Manager Console you can install it with the following command:

	PM> Install-Package AWSSDK

Now we can safely have Visual Studio build out our Controllers and Views. Lets start with the Controllers. Right click for the context menu on the Controllers directory in the Solutions Explorer and choose `Add -> Controller...`

This will pull up the followig dialog where you want to type the name of the controller `PhotosController`

<img src="https://z.zr.io/rw/tutorials/responsive-upload/s3upload-add-controller-dialog.png" alt="">


Controllers/PhotosController.cs ( [view on github](), [raw]() ) :

	using System;
	using System.Collections.Generic;
	using System.Data;
	using System.Data.Entity;
	using System.Linq;
	using System.Web;
	using System.Web.Mvc;
	using SimpleMVCUpload.Models;
	using System.IO;
	using Amazon.S3;
	using Amazon.S3.Model;

	namespace SimpleMVCUpload.Controllers
	{
	    public class PhotosController : Controller
	    {
	        public static void FileUploadToS3(string bucketName, string fileName, Stream fileContent, bool isPublic, AmazonS3Client s3Client)
	        {
	            if (String.IsNullOrEmpty(fileName))
	            {
	                return;
	            }
	            PutObjectRequest putObjectRequest = new PutObjectRequest();
	            putObjectRequest.WithBucketName(bucketName);
	            putObjectRequest.CannedACL = S3CannedACL.PublicRead;
	            putObjectRequest.Key = fileName;
	            putObjectRequest.InputStream = fileContent;
	            S3Response response = s3Client.PutObject(putObjectRequest);
	            response.Dispose();
	        }

	        ...
	        

	        public ActionResult ImageUpload(string Caption, HttpPostedFileBase file)
	        {
	            if (file != null)
	            {
	                string[] whiteListedExt = { ".jpg", ".gif", ".png", ".tiff" };
	                Stream stream = file.InputStream;
	                string extension = Path.GetExtension(file.FileName);
	                if (whiteListedExt.Contains(extension))
	                {
	                    string pic = "somedirectory/" + Guid.NewGuid() + extension;
	                    using (AmazonS3Client s3Client = new AmazonS3Client(Amazon.RegionEndpoint.USWest2))
	                        FileUploadToS3("YOUR-AWS-S3-BUCKET-NAME-HERE", pic, stream, true, s3Client);
	                    TempData["ImageUploadError"] = null; // success
	                    Photo photo = new Photo();
	                    photo.Caption = Caption;
	                    photo.ImageURL = pic;
	                    photo.UploadDate = DateTime.Now;
	                    photo.Rank = 0;
	                    db.Photos.Add(photo);
	                    db.SaveChanges();
	                }
	                else
	                {
	                    TempData["ImageUploadError"] = "You must upload an image file";
	                }

	            }
	            else
	            {
	                TempData["ImageUploadError"] = "Your must select a file to upload";
	            }
	            return RedirectToAction("Index", "Photos");

	            ...

	        }
	    }
	}

Make sure you replace `YOUR-AWS-S3-BUCKET-NAME-HERE` with the name of your AWS S3 Bucket. To make sure you stay compatibile with the Imazen Image Resizer S3 Plugin, make sure you follow these naming conventions for your bucket name.

* Bucket names should not contain upper case letters
* Bucket names should not contain underscores (_)
* Bucket names should not end with a dash
* Bucket names should be between 3 and 63 characters long
* Bucket names cannot contain dashes next to periods (e.g., "my-.bucket.com" and "my.-bucket" are invalid)
* Bucket names cannot contain periods - Amazon states this is not supported for SSL-secured access, due to DNS complications. Your mileage may vary.

source: [http://imageresizing.net/plugins/s3reader](http://imageresizing.net/plugins/s3reader)

Views/Photos/Create.cshtml ( [view on github](), [raw]() ) :

	@using (Html.BeginForm("ImageUpload", "Photos", FormMethod.Post, new { enctype = "multipart/form-data" })) {
	    @Html.AntiForgeryToken()
	    @Html.ValidationSummary(true)

	    <fieldset>
	        <legend>Photo</legend>

	        <label for="file">Upload Image:</label>
	        <input type="file" name="file" id="file" style="width: 100%;" />

	        <div class="editor-label">
	            @Html.LabelFor(model => model.Caption)
	        </div>
	        <div class="editor-field">
	            @Html.EditorFor(model => model.Caption)
	            @Html.ValidationMessageFor(model => model.Caption)
	        </div>

	        <p>
	            <input type="submit" value="Create" />
	        </p>
	    </fieldset>
	}

	<div>
	    @Html.ActionLink("Back to List", "Index")
	</div>

	@section Scripts {
	    @Scripts.Render("~/bundles/jqueryval")
	}


## Using Foundation in MVC 4


