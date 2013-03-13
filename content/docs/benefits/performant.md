
# ImageResizer Performance

### ImageResizer is a high-performance HttpModule with efficient IIS integration
Application frameworks, such as ASP.NET, MVC, Web API, and Rails, are inherently bad at serving big files. They’re designed for small HTML, XML, or JSON communications, after all.

That’s why ImageResizer is implemented as an HttpModule.

By turning request processing over to kernel-speed IIS code for the actual serving of content, ImageResizer achieves speed, throughput, and scalability unachievable with an HttpHandler or MVC ActionResult. All ImageResizer processing occurs during PostAuthorizeRequest, allowing IIS to handle the ProcessRequest phase.

ImageResizer is a RESTful Imaging API. It can scale up, scale out, and scale down (embeddable). 

ImageResizer’s DiskCache is designed for high concurrency. Its low-overhead threading designs ensure hundreds of concurrent imaging commands can run in parallel. 

Two simultaneous requests for the same image modification won’t cause duplicate work - instead, both requests receive a response simultaneously as soon as the image is ready, and the result is asynchronously flushed to the disk cache as soon as it’s efficient to do so. In the mean time, it’s served from a single memory block to all requestors

## Scalability - Traffic

IIS has unique access to the HTTP.SYS kernel-mode caching system, and ImageResizer takes advantage of it. Ethernet speeds are generally the bottleneck when it comes to traffic quantity. Being RESTful, it’s happy behind Amazon CloudFront or Azure CDN, as long as you remember to enable querystrings.

## Scalability - Image Count

DiskCache is as scalable as the underlying filesystem. On a traditional hard drive, NTFS begins slowing down at 500K files. On a high-speed disk or RAID array, performance can stay acceptable until 1-2 million files. With an SSD, it’s common to scale to 8 million files on a single filesystem without serious issues. 

Scaling past 10 million unique images generally requires a blob storage service such as Amazon S3 or Azure on the backend and a CDN or http cache on the front, like CloudFront and/or Varnish.




