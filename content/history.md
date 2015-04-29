# History of ImageResizer

The ImageResizer was created in January 2007 to simplify the process of changing website layouts and slideshow sizes. Resizing images manually (even in bulk) was taking hours each day, at significant cost to the company.

ImageResizer was designed with security, stability, and performance in mind from day 1. It has always used proper memory (and resource) management techniques, and has leveraged disk caching to provide ideal scalability. Compatibility with XP through Windows 8 (and Server 2000 through Server 8) has always been maintained.

ImageResizer has always included source code under a very permissive license, although users were charged a 'download fee' for V1 and V2. Despite offering no-questions-asked refunds for any reason, no user has ever asked for a refund due to dissatisfaction with the product.

### Release History 

Version 1 was released to the public August 6, 2008 after 1.5 years of testing on several high-traffic sites.

#### Version 2
Version 2 was a complete rewrite, and was released to users of v1 in January 2009, and was published in May 2009. 

V2 introduced IIS7 support (HttpModule instead of HttpHandler design), a nicer managed API, and support for Octree GIF quantization among other features. See [the V2 changelog for details](/docs/v2/changelog).

V2 was used by hundreds of developers, integrated into roughly a dozen content management systems, and used by hosting companies.

After two years of improving V2, another rewrite was needed to allow future improvement. We maintained full compatibility with the V2 URL syntax, but overhauled the managed API.

#### Version 3

The goal of the V3 rewrite was to make everything open and extendable. V2 was a monolithic design that, while elegant and very concise, was hard to extend except through source code modification. V3 introduced the concept of Plugins and added an array of Events that can be used to customize the behavior of the pipeline.
It also introduced a dedicated configuration section for the Resizer and its plugins.

V3 was released [Apr. 24](/releases/3-alpha-2) after 4 months of coding and testing. [Alpha 7](/releases/3-alpha-7) was released May 26, and we back-ported many bug fixes to V2 with the [May 27, 2011 release of 2.8](/releases/2-8). A collection of pages on the V2 to V3 differences is [available here](/docs/2to3/).

The V3 core is under [an MIT-like license](/licenses/freedom). This license is much clearer than the V2 license.

Some V3 plugins are under a [slightly more restrictive license](/licenses), but even those give you redistribution and sub-licensing rights. If your project needs a different license, [contact us](/support). We offer OEM, open-source, and integration licenses to fit every need.

ImageResizer can be found on GitHub at [github.com/imazen/resizer](https://github.com/imazen/resizer). Our [release history for V3 may also help you locate changelog information](/releases).

Due to the design of V3, we were able to maintain backwards compatibility through 4 years of steadily adding plugins, pipelines, and functionality. The v3 of 2014 barely resembles the v3 of 2011 in terms of capabilities; yet painless upgrades between versions of v3 are possible.

#### Version 4

Version 4 is the first version of ImageResizer that is OSI-compliant. All software is available under the AGPL v3, and the ImageResizer Core and 18 plugins from the Essential edition are under the Apache 2 license.

v4 introduces async support, requires .NET 4.5, and drops support for medium trust. It is highly backwards-compatible with v3, but does make some breaking changes to support new scenarios and functionality. 

v4 also introduces a high-performance, high-quality image scaling component that can work side-by-side with GDI+, allowing up to 8x the throughput while retaining all the functionality and compatibility of the default pipeline.

### Imazen

Imazen was formed on May 18th 2012 to provide a better framework for ImageResizer's growth and support contract offerings, and is now the official business entity behind all things ImageResizer. 

Our expanded software development team has enabled us to improve ImageResizer at a much faster rate and provide better support to our users. We encourage you [to review our support contract offerings](/support/contracts) and consider leveraging our extensive experience in image processing systems.


