Redirect To: /docs/basics


# Usage examples

<style type="text/css">
.lineup img {vertical-align:top;}
</style>

## Width & Height

You can set bounds for an image with the `width` and/or `height` commands. How those bounds are interpreted is determined by the `mode` command. If only `width` *or* `height` is specified, aspect ratio is maintained.

![Resizing modes](/attachments/resizing-modes.png)

Note:  `mode=carve` requires the [SeamCarving plugin](/plugins/seamcarving). 

## Scale=down|both|canvas

By default, images are *not* enlarged - the image stays its original size if you request a larger size.


To allow both reduction and enlargement, use `scale=both`. Image enlargement causes blurriness and should be avoided. `scale=canvas` is another option. The image never gets upscaled, but the canvas is expanded to fill the desired area.

Here we attempt to upscale an image using `scale=down`, `scale=both`, and `scale=canvas` respectively.

<img src="http://img.imageresizing.net/clock.gif;width=100;frame=1" style="border: 1px solid gray" />
<img src="http://img.imageresizing.net/clock.gif;width=100;scale=both;frame=1" style="border: 1px solid gray"  />
<img src="http://img.imageresizing.net/clock.gif;width=100;scale=canvas;frame=1" style="border: 1px solid gray"  />

You can [change the default behavior from `scale=down` to something else with the DefaultSettings plugin](/plugins/defaultsettings).

## Alignment

So, you don't like images being centered when you use `mode=crop`, `mode=pad`, or `scale=canvas`? You can pick the alignment type with the `anchor` command. 

Valid values are `topleft`, `topcenter`, `topright`, `middleleft`, `middlecenter`, `middleright`, `bottomleft`, `bottomcenter`, and `bottomright`.

## Formats & compression

Set `format=jpg`, `format=gif`, or `format=png` to force a particular output format. By default, the original format (or the closest match) is used.

Adjust jpeg compression with the `quality=10..100` command. The default is 90, an excellent tradeoff between size and perfection. 

You need the [PrettyGifs plugin](/plugins/prettygifs) to get acceptable GIF quality, adjust compression, or even support transparency. Windows support for GIF files is terrible.

If you want to generate 8-bit PNG files, you'll also need the PrettyGifs plugin. Only 32-bit PNG files are supported by default. 

## Rotate

Use the embedded camera information to auto-rotate source images with the `autorotate=true` command and the [AutoRotate](/plugins/autorotate) plugin.

Manually adjust with `srotate=90|180|270` or `rotate=degrees`. You can also flip with `sflip=x|y|xy` and `flip=x|y|xy`. Commands starting with 's' occur before resizing & processing instead of afterwards. 


## Manual crop

You can specify manual cropping with the `crop=x1,y1,x2,y2` command. If you don't know the original size of the image, you can specify what size your coordinates are relative to with `cropxunits=100` and `cropyunits=100` (which, for example, make the crop units percentages). 

This allows extremely easy integration with visual cropping tools like jCrop. 

## Scale by factor

What if you need to scale your result image up or down by an arbitrary multiplier (such as for mobile device support)? Use `zoom=-000.1..1000`. You still have to set `scale=both` to enlarge images, but you your other commands can remain untouched. For example, `img.jpg?w=100&h=100` is 100px sqare, but `img.jpg?w=100&h=100&zoom=2` is 200px sq.

## Background & border colors

Dislike white? Transparent padding is added (when required) for PNGs and GIFs, but jpegs don't support transparency.

Add **bgcolor=name** or **bgcolor=33ddff** to set the background color. Named colors and hex values supported.

<img src="http://img.imageresizing.net/quality-original.jpg;w=100;h=100;bgcolor=33ddff" />

And if you're tired of dealing with the box model, you can add an image border easily without messing up your CSS. 

<img src="http://img.imageresizing.net/quality-original.jpg;w=100;borderWidth=10;borderColor=gray" />




Version 3 and version 2 are fully compatible - all v2 commands work in v3 (with the right plugins installed).

[View version 2 usage examples](http://nathanaeljones.com/155/image-resizer-v2-examples/)

[Full command reference](/docs/reference)