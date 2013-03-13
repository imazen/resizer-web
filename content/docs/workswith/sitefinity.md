Tags: cms

#Sitefinity and ImageResizer

Sitefinity 3.X and earlier versions require no additional steps.

Sitefinity 4.X and later versions prevent external libraries and code from accessing uploaded files in a standardized manner (They no longer support ASP.NET's VirtualPathProvider system, nor do they provide an equivalent). 

URIs are a good way to identify files, and we are disappointed that Sitefinity 4.X+ does not provide an API which accepts a virtual path.

While we are looking for a solution that supports all Sitefinity 'Providers' and 'Libraries' in an integrated way, you can use our existing plugins to access the data-stores behind the providers directly. SqlReader can be used if you're uploading files to SQL, and S3Reader, AzureReader, or RemoteReader if you're uploading to blob storage. If you're uploading to the local filesystem, you can use the VirtualFolder plugin to modify the path. 
