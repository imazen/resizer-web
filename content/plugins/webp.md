Bundle: contract
Edition: elite
Tagline: Decode and encode .webp images

# WebP plugins

## Installation

1. Either run `Install-Package ImageResizer.Plugins.WebP` in the NuGet package manager, or add `ImageResizer.Plugins.WebP.dll` to your project.

2. Add `<add name="WebPEncoder" />` and/or `<add name="WebPDecoder" />` inside `<resizer><plugins></plugins></resizer>` in Web.config.

## WebPDecoder

Simply reference a .webp file as you would a .jpg

  image.webp?width=100&format=jpg

A 100px wide jpeg will be returned. 

If the extension is not .webp, you can add `&decoder=webp` to force webp decoding first, instead of waiting for the fallback path.


## WebPEncoder

Add `&format=webp` to any URL to encode the result in webp format instead of jpg/png

### Parameters

* Quality=1..100
* Lossless=true/false (defaults false)
* NoAlpha=true/false (defaults false)


### Rule of thumb for converting jpeg quality values to webp

In general, webp achieves the same visual quality with a much lower  `quality` parameter. 

The first value is the jpeg quality, second is webp quality for same visual clarity.

* 90->78
* 80->65 
* 70->55 
* 50->40
* 40->30
* 20->10
* 10->3
* 5->0

