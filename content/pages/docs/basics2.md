flags: hidden

# Slightly more advanced



## Rotate

Use the embedded camera information to auto-rotate source images with the `autorotate=true` command and the [AutoRotate](/plugins/autorotate) plugin.

Manually adjust with `srotate=90|180|270` or `rotate=degrees`. You can also flip with `sflip=x|y|xy` and `flip=x|y|xy`. Commands starting with 's' occur before resizing & processing instead of afterwards. 


## Manual crop

You can specify manual cropping with the `crop=x1,y1,x2,y2` command. If you don't know the original size of the image, you can specify what size your coordinates are relative to with `cropxunits=100` and `cropyunits=100` (which, for example, make the crop units percentages). 

This allows extremely easy integration with visual cropping tools like jCrop. 




margin, padding, and borders




## Scale by factor

What if you need to scale your result image up or down by an arbitrary multiplier (such as for mobile device support)? Use `zoom=-000.1..1000`. You still have to set `scale=both` to enlarge images, but you your other commands can remain untouched. For example, `img.jpg?w=100&h=100` is 100px sqare, but `img.jpg?w=100&h=100&zoom=2` is 200px sq.

## Whitespace trimming

## Gradient

## IEPngFix

## MobileRescale

?autosize=screen
?rescalefrom=1024x768


## [Watermark plugin](/plugins/watermark)

* **watermark** - The name of one or more watermark layers (or layer groups) to render.




## Margins, padding, and borders

And if you're tired of dealing with the box model, you can add an image border easily without messing up your CSS. 

<img src="http://img.imageresizing.net/quality-original.jpg;w=100;borderWidth=10;borderColor=gray" />
