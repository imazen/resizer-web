---
:append: provider_info
:tags: plugin
:edition: performance
:tagline: Base class for creating your own blob provider
:aliases: "/plugins/blobproviderbase /plugins/blobprovider"
:edit_info: develop/plugins/imageresizer.storage/readme.md
---

# BlobProviderBase plugin

BlobProviderBase allows you to quickly create a file provider for ImageResizer - while only implementing 2 methods. 

```
/// <summary>
/// Should perform an immediate (uncached) query of blob metadata (such as existence and modified date information)
/// </summary>
/// <param name="virtualPath"></param>
/// <param name="queryString"></param>
/// <returns></returns>
public abstract Task<IBlobMetadata> FetchMetadataAsync(string virtualPath, NameValueCollection queryString);


public abstract Task<Stream> OpenAsync(string virtualPath, NameValueCollection queryString);
```

BlobProviderBase supports both synchronous and asynchronous interfaces, and can optionally expose your files via a VirtualPathProvider as well. It also offers metadata caching to minimize server round-trips. 


## Configuration