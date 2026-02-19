---
title: "Compatible"
description: "ImageResizer works with your CMS, CDN, storage backend, hosting provider, and .NET version."
---

ImageResizer integrates with the infrastructure you already have. No rip-and-replace — add it to your existing stack.

## Image storage backends

ImageResizer can read source images from any of these:

- **Local filesystem** — default, zero config
- **Amazon S3** — via S3Reader plugin
- **Azure Blob Storage** — via AzureReader2 plugin
- **Microsoft SQL** — via SqlReader plugin
- **MongoDB GridFS** — via MongoReader plugin
- **Remote HTTP servers** — via RemoteReader plugin

## CMS integration

Drop ImageResizer into your CMS and every image it serves becomes resizable via URL:

- **Umbraco** — first-class integration, most popular pairing
- **DNN (DotNetNuke)** — widely deployed
- **Orchard CMS** — works out of the box
- **Ektron** — compatible
- **EPiServer** — community-documented integration
- **Sitecore** — compatible with pipeline customization
- **Sitefinity** — compatible
- **Kentico** — compatible
- **WordPress (.NET hosted)** — via remote reader
- **30+ other ASP.NET CMSes** — if it runs on IIS, ImageResizer works

## CDN support

ImageResizer is RESTful — put any CDN in front and it works:

- **Amazon CloudFront** — enable querystring forwarding
- **Azure CDN** — enable querystring caching
- **Akamai** — configure querystring as cache key
- **MaxCDN / StackPath** — full support
- **Varnish** — include querystring in cache hash
- **CloudFlare** — works with querystring passthrough

## Input formats

- JPEG, PNG, GIF (including animated), BMP, TIFF, WMF, EMF
- **PSD** — via PsdReader plugin
- **PDF** — via PdfRenderer plugin (page-to-image)
- **WebP** — via WebP plugin
- **RAW camera formats** — via FreeImage plugin (CR2, NEF, DNG, etc.)

## Output formats

- JPEG (configurable quality)
- PNG (8-bit and 32-bit)
- GIF
- WebP (via WebP plugin)

## Hosting providers

ImageResizer runs anywhere ASP.NET runs:

- Standard Windows Server / IIS
- **Azure App Service** (Web Apps)
- **Azure Cloud Services**
- **Amazon EC2** (Windows)
- **AppHarbor**
- **DiscountASP.NET**
- **GoDaddy** (Windows hosting)
- Shared hosting — works in medium trust with minor config

## Operating systems

- Windows Server 2008 R2 through 2022
- Windows 7 through 11 (development)
- Azure (all Windows offerings)

## Web servers

- **IIS 7.0+** — recommended, full pipeline integration
- **IIS 6** — supported via ISAPI (v3)
- **IIS Express** — development
- **Cassini / VS Dev Server** — development

## .NET versions

- **.NET 4.5+** — recommended for v4
- **.NET 4.0** — v3 and v4
- **.NET 3.5** — v3
- **.NET 2.0** — v3 (limited plugin support)
