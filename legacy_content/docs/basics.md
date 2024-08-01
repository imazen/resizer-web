Aliases: /docs/examples /docs/howto/crop

# Basic commands

<style type="text/css">
.lineup img {vertical-align:top;}
</style>

## Width & Height

You can set bounds for an image with the `width` and/or `height` commands. How those bounds are interpreted is determined by the `mode` command. If only `width` *or* `height` is specified, aspect ratio is maintained.

![Resizing modes](http://z.zr.io/rw/diagrams/resizing-modes.png)

Note:  `mode=carve` requires the [SeamCarving plugin](/plugins/seamcarving). 

## Scale=down|both|canvas

**By default, images are *not* enlarged** - the image stays its original size if you request a larger size.


To allow both reduction and enlargement, use `scale=both`. Image enlargement causes blurriness and should be avoided. `scale=canvas` is another option. The image never gets upscaled, but the canvas is expanded to fill the desired area.

Here we attempt to upscale an image using `scale=down`, `scale=both`, and `scale=canvas` respectively.

<img src="https://z.zr.io/ri/tractor-tiny.jpg;width=150;scale=down" style="border: 1px solid gray" />
<img src="https://z.zr.io/ri/tractor-tiny.jpg;width=150;scale=both" style="border: 1px solid gray"  />
<img src="https://z.zr.io/ri/tractor-tiny.jpg;width=150;scale=canvas" style="border: 1px solid gray"  />

You can [change the default behavior from `scale=down` to something else with the DefaultSettings plugin](/plugins/defaultsettings).

## Alignment

So, you don't like images being centered when you use `mode=crop`, `mode=pad`, or `scale=canvas`? You can pick the alignment type with the `anchor` command. 

Valid values are `topleft`, `topcenter`, `topright`, `middleleft`, `middlecenter`, `middleright`, `bottomleft`, `bottomcenter`, and `bottomright`.

Mode=Crop, Anchor=Topleft: ![](https://z.zr.io/ri/zermatt.jpg;w=100;h=100;mode=crop;anchor=topleft)
Anchor=bottomright: ![](https://z.zr.io/ri/zermatt.jpg;w=100;h=100;mode=crop;anchor=bottomright)

Mode=Pad, Bgcolor=gray, Anchor=Topleft: ![](https://z.zr.io/ri/zermatt.jpg;w=100;h=100;bgcolor=gray;anchor=topleft)
 Anchor=bottomright: ![](https://z.zr.io/ri/zermatt.jpg;w=100;h=100;bgcolor=gray;anchor=bottomright)

Scale=canvas, bgcolor=gray, Anchor=Topleft: ![](https://z.zr.io/ri/tractor-tiny.jpg;w=150;bgcolor=gray;scale=canvas;anchor=topleft)

## Formats & compression

Set `format=jpg`, `format=gif`, or `format=png` to force a particular output format. By default, the original format (or the closest match) is used; however, you can convert *any* format file to *any* other file, maintaining transparency, IF the [PrettyGifs plugin](/plugins/prettygifs) is installed.

Adjust jpeg compression with the `quality=0..100` command. The default is 90, an excellent tradeoff between size and perfection. 

0: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=0)
5: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=5)
10: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=10)
20: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=20)
30: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=30)
40: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=40)
50: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=50)
60: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=60)
70: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=70)
80: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=80)
85: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=85)
90: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=90)
95: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=95)
100: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;quality=100)


You need the [PrettyGifs plugin](/plugins/prettygifs) to get acceptable GIF quality, adjust compression, or even support transparency. Windows support for GIF files isn't as efficient. You'll also need the [AnimatedGifs plugin](/plugins/animatedgifs) if you're using those. 

If you want to generate 8-bit PNG files, you'll also need the PrettyGifs plugin. Only 32-bit PNG files are supported by default. 

Adjusting compression in GIF files happens by setting the `colors=2..256` command.

### With PrettyGifs

16: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=16;format=gif)
32: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=32;format=gif)
64: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=64;format=gif)
128: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=128;format=gif)
256: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=256;format=gif)

With dithering: 16: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=16;format=gif;dither=true)
64: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=64;format=gif;dither=true)
256: ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=256;format=gif;dither=true)

### Without PrettyGifs, on Server 2008 and above

256 colors (You cannot adjust compression): ![](https://z.zr.io/ri/tulip-leaf.jpg;width=100;colors=256;format=gif;encoder=gdi)

### Without PrettyGifs, on Server 2003 and below

256 colors (You cannot adjust compression): ![](https://z.zr.io/ri/tulip-leaf-ws2003.gif)

## Background color

Dislike white? Transparent padding is added (when required) for PNGs and GIFs, but jpegs don't support transparency.

Add **bgcolor=name** or **bgcolor=33ddff** to set the background (matte) color. Named colors and hex values supported.

<img src="https://z.zr.io/ri/quality-original.jpg;w=100;h=100;bgcolor=33ddff" />

## Cropping 

The URL syntax for cropping is `&crop=x1,y1,x2,y2`. The coordinates are relative to the top-left corner of the original image - if they are positive values.

If X2 or Y2 are 0 or less, they are relative to the bottom-right corner. This allows easy trimming without knowing the size of the image.

For example, crop=0,0,0,0 leaves the image uncropped. crop=10,10,-10,-10 removes 10 pixels from all edges of the image.

In addition, you can specify `cropxunits` and `cropyunits`. Setting them to 100 allows you to crop by percentage. Example which crops 10% off each edge: `?cropxunits=100&cropyunits=100&crop=10,10,90,90`. Setting them to the width/height of the display image allows you to crop in display coordinates, without needing to know the original size of the image.


## Disk Caching - why you need it

Every public-facing website needs disk caching for their dynamically resized images (no, ASP.NET's output cache won't work). This module is extremely fast, but decoding the original image requires a large amount of **contiguous** RAM (usually 50-100MB) to be available. Since it requires contiguous, non-paged, non-fragmented RAM, it can't be used as a (D)DOS attack vector, but it does mean that there is a RAM-based limit on how many concurrent image processing requests can be handled. The [DiskCache plugin](/plugins/diskcache) improves the throughput 100-10,000X by delegating the serving of the cached files back to IIS and by utilizing a hash-tree disk structure. It easily scales to 100,000 variants and can be used with as many as a million images. The DiskCache plugin requires you to use the URL API ([read why](/docs/best-practices)).

### Controlling disk caching of results

* Cache=No - Prevents the current request from being disk cached
* Cache=Default - Caches the image if it is processed, doesn't cache the image if it's served unmodified
* Cache=Always - Forces the current image request to be disk cached, even if the image isn't modified. Useful for remotely stored images.

### Controlling processing

* Process=No - Prevents the requested image from being modified. Useful if you want to cache but not process an image
* Process=Default - Processes the image only if one of the [defined querystring commands](/docs/reference) are being used.
* Process=Always - Forces re-encoding of the image, even if no other operations are requested. Good for preventing XSS attacks from untrusted image sources.

## Edge Caching - why you need it

If you have visitors farther than ~600 miles away from your server, you can further improve their experience with edge caching. Amazon CloudFront and Microsoft CDN have made it very affordable; my monthly CloudFront bill averages less than $2. Faster website response times mean more sales, according to every study I've read on the topic. Of course, I would imagine that kind of study is naturally biased, but it does seem to be a logical conclusion. 

A CDN also helps your scalability. By reducing the static file load handled by your application server, you free it up to handle ASP.NET page requests faster. Disk caching is still important however, as each of the hundreds of edge caching locations makes an independent request for a given image, and does not guarantee that it will stay in the cache for as long as you want. Even with edge caching on for all your images, you'll still see a great response time and throughput improvement by enabling the DiskCache plugin. 

## Back to cooler stuff...

The following filters require the [SimpleFilters plugin](/plugins/simplefilters), part of the Creative edition.

![Original image](https://z.zr.io/ri/utah2.jpg;width=200)


### 4 ways to grayscale

`s.grayscale`=`true|y|ry|ntsc|bt709|flat`  (true, ntsc, and y produce identical results)

The following examples use NTSC/Y/True, RY, BT709, and Flat respectively

![s.grayscale=true](https://z.zr.io/ri/utah2.jpg;width=200;s.grayscale=true)
![s.grayscale=ry](https://z.zr.io/ri/utah2.jpg;width=200;s.grayscale=ry)
![s.grayscale=bt709](https://z.zr.io/ri/utah2.jpg;width=200;s.grayscale=bt709)
![s.grayscale=flat](https://z.zr.io/ri/utah2.jpg;width=200;s.grayscale=flat)

### 1 way to sepia

![s.sepia=true](https://z.zr.io/ri/utah2.jpg;width=200;s.sepia=true)

### Inversion

![s.invert=true](https://z.zr.io/ri/utah2.jpg;width=200;s.invert=true)


### Adjust opacity/alpha

`s.alpha`= `0..1`

For true transparency, combine with `format=png`. Otherwise, the image will be blended against `bgcolor`.

![s.alpha=0.25](https://z.zr.io/ri/utah.jpg;width=200;s.alpha=0.25)
![s.alpha=0.75](https://z.zr.io/ri/utah.jpg;width=200;s.alpha=0.75)
![s.alpha=0.85](https://z.zr.io/ri/utah.jpg;width=200;s.alpha=0.85)
![s.alpha=1](https://z.zr.io/ri/utah.jpg;width=200;s.alpha=1)

### Adjust contrast


`s.contrast`= `-1..1`


![s.contrast=-0.80](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=-0.99)
![s.contrast=-0.80](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=-0.80)
![s.contrast=-0.40](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=-0.40)
![s.contrast=-0.20](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=-0.20)

![s.contrast=0](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=0)


![s.contrast=0.20](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=0.20)
![s.contrast=0.40](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=0.40)
![s.contrast=0.80](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=0.80)
![s.contrast=0.99](https://z.zr.io/ri/utah.jpg;width=200;s.contrast=0.99)



### Adjust brightness


`s.brightness`= `-1..1`


![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=-1)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=-0.7)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=-0.5)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=-0.2)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=0)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=0.2)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=0.5)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=0.7)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.brightness=1)

### Adjust saturation


`s.saturation`= `-1..1`



![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=-1)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=-0.9)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=-0.5)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=-0.2)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=0)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=0.2)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=0.5)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=0.9)
![](https://z.zr.io/ri/red-leaf.jpg;width=100;s.saturation=1)

These are just a few of the available commands. To learn more, see the [full command reference](/docs/reference)

Not covered here: cropping, zooming, rotating, padding, margins, borders, shadows, watermarks, 404s, auto-trim, and alternate pipelines.
