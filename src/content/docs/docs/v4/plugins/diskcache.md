---
title: "DiskCache plugin"
description: "Makes dynamic image processing as responsive and scalable as static images"
---

Writes resized images directly to disk, then lets IIS serve them as normal images. Uses URL rewriting, not URL redirects - this maintains the filename for SEO and reduces latency.

With this plugin, a server can usually process as many concurrent 'dynamic' image requests as 'static' image requests, since there is only a 1-time hit (and it's small to begin with) for resizing an image.

Suggested for all live sites. Works well in combination with the CloudFront plugin, which adds edge-caching. Also works great with the PsdReader, SqlReader, S3Reader, and AnimatedGifs plugin; these benefit greatly from caching due to their slightly higher resource cost.

Compatible with *all* plugins.

This plugin only applies to the URL API, not the managed API. It integrates deeply with ASP.NET and IIS to provide ideal performance.

When disabling DiskCache on a site that hosts protected images, it is best to use `<diskcache enabled="false" />` instead of removing `<add name="DiskCache" />`. The existing `/imagecache/` folder will otherwise become publicly accessible when the plugin is removed. Keep this in mind with sub-applications as well.

All images are cached by default. Specify `&cache=no` to prevent caching of a result. The disk cache can be (roughly) constrained by image count using `subfolders=x` and `autoClean=true`. Evicting items from disk is expensive, so we don't enable this by default, nor suggest it unless monitoring proves it necessary.

## Installation

Either run `Install-Package ImageResizer.Plugins.DiskCache` in the NuGet package manager, or:

1. Add a reference to ImageResizer.Plugins.DiskCache.dll file in your project.
2. In the plugins section, insert `<add name="DiskCache" />`.

You're done. If you want to configure the cache directory, you can set `<diskcache dir="~/app-relative-path-here" />`.


# Other plugins included with DiskCache

The DiskCache assembly includes 3 additional caching plugins

## SourceMemCache (beta)

Caches up to 10MB of original image files in memory. Files not accessed for more than 10 minutes are removed from the cache.

Improves performance for real-time image editing (such as via StudioJS or jCrop).

**Only images with `&scache=mem` are cached.**

Install by adding `<add name="SourceMemCache" />`.


## Output MemCache (alpha)

Caches up to 10MB of output image files in memory. Files not accessed for more than 10 minutes are removed from the cache.

Useful for few-time-use image processing, such as a live camera feed.

**Only images with `&mcache=true` are cached.**

Install by adding `<add name="MemCache" />`.

## SourceDiskCache (beta)

Like DiskCache, but for source files. Not advisable if your source image collection is larger than available local storage.

**Only images with `&scache=disk` are cached.**

Install by adding `<add name="SourceDiskCache" />`.

Default cache folder is `~/cache/sourceimages`. No configuration options available through XML installation - only through code installation.

## DiskCache Configuration

The defaults are good - you don't actually need to specify any configuration.

The following is what the default settings look like. Only specify what you need to change.

```
<diskCache dir="~/imagecache" autoClean="false" hashModifiedDate="true" enabled="true"
 subfolders="8192" cacheAccessTimeout="15000" asyncWrites="false" asyncBufferSize="10485760" />

<cleanupStrategy startupDelay="00:05" minDelay="00:00:20" maxDelay="00:05"
  optimalWorkSegmentLength="00:00:04"
  targetItemsPerFolder="400" maximumItemsPerFolder="1000"
  avoidRemovalIfCreatedWithin="24:00" avoidRemovalIfUsedWithin="4.00:00"
  prohibitRemovalIfUsedWithin="00:05" prohibitRemovalIfCreatedWithin="00:10" />
```

### dir

Where to store the images. This can specify an IIS virtual directory if you want to cache images outside the site folder.

Should be in virtual path form, like `/vdir/cache` or `~/imagecache`.

### autoClean

When true, will keep a background thread running to 'clean' unused items from the disk cache. This background thread uses smart 'activity sensing' to avoid doing cleanup work when the site is busy.
Defaults to false, since the cleanup system is still in beta.

### hashModifiedDate

If true, when a source file is changed, a new file will be created instead of overwriting the old cached file.
This helps prevent file lock contention on high-traffic servers. Defaults to true.
Changes the hash function, so you should delete the cache folder whenever this setting is modified.

Never use 'False' in a Web Garden scenario - it will cause random failed requests. False may also cause rare failed requests during an overlapped recycle (which is the default for IIS). False may also cause failed requests if a source image is updated while the older version is still being streamed to clients, and those requests take over 'cacheAccessTimeout' seconds.
False has the benefit of creating less 'cache trash', since extra files are not left around for a while; however, the benefits rarely outweigh the disadvantages.

### enabled

true by default. False disables the plugin completely, but prevents public access to `~/imagecache`, which would become possible if you simply uninstalled the plugin.

### subfolders

Controls how many subfolders to use for disk caching. Rounded to the next power of two.

NTFS does not handle more than 8,000 files per folder well. Larger folders also make cleanup more resource-intensive.

Defaults to 8192, which combined with the default setting of 400 images per folder, allows for scalability to ~1 million actively used image versions.

For example, given a desired cache size of 100,000 items, this should be set to 256.

### cacheAccessTimeout

Defaults to 15 seconds. How long to wait for a file lock to become available before giving up on the request.

### asyncWrites

When true, writing to the disk cache will occur on separate threads, permitting the request to complete faster in the case of a cache miss.
This adds a bit more overhead on the server, but makes the client experience more responsive. Very helpful on slow or overwhelmed I/O systems.

### asyncBufferSize

The number of bytes to allowed to be used for the async write queue. Defaults to 10MB (10485760). This is the maximum amount of RAM that will be used for the write cache.
If this value would be exceeded, the disk cache switches to synchronous mode until the queue has emptied enough to permit another job to be added without exceeding the maximum.


## CleanupStrategy

Controls how the background thread determines which files to 'clean up'. Not used unless `autoClean='true'`

Changing the `cleanupStrategy` settings may void your warranty - it's tricky business.

Times are parsed in the following format:  `{ s \| d.hh:mm[:ss[.ff]] \| hh:mm[:ss[.ff]] }`. If you just enter a number, it's considered seconds.


## Version history

### v4.3 (current)

* Bug fix: `asyncFailed` flag was inverted, so sync fallback was not being logged correctly.
* Bug fix: `QueueAsync` return type changed from `bool` to `AsyncQueueResult` enum. Duplicate writes now return `AlreadyPresent` instead of failing.
* Bug fix: Async write exception safety improved - queue entries are now cleaned up in a `finally` block.
* Bug fix: Subfolder hash bit clearing in `UrlHasher.getSubfolder()`.
* Race condition mitigation: `FlushAccessedDate` is now delayed by 10 seconds to avoid interfering with concurrent reads.
* All .NET Framework projects now target .NET 4.7.2 (previously 4.5/4.5.2).

### v4.2.8 and prior

* Targeted .NET 4.5/4.5.2.
* `QueueAsync` returned `bool` (true/false) rather than a descriptive enum.
* The async write bugs listed above were present.
