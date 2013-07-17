Bundle: 2
Edition: creative
Tagline: Adjust photo transparency, brightness, and apply sepia and B&W filters through the querystring. Nearly zero performance overhead - matrix-based.

# SimpleFilters plugin

This plugin provides grayscale, sepia, brightness, saturation, contrast, inversion, and alpha filtering options. It also includes beta support for rounded corners.

These filters are implemented as adjustment matrices and are processed by native code for very high performance.


## Installation

Either run `Install-Package ImageResizer.Plugins.SimpleFilters` in the NuGet package manager, or:

1. Add ImageResizer.Plugins.SimpleFilters.dll to your project
2. Add `<add name="SimpleFilters" />` inside `<resizer><plugins></plugins></resizer>` in Web.config.


## Usage (v3.1+)

**Note the order in which effects are applied *MAY CHANGE* in future releases**

* &s.grayscale=true|y|ry|ntsc|bt709|flat  (true, ntsc, and y produce identical results)
* &s.sepia=true
* &s.alpha= 0..1
* &s.brightness=-1..1
* &s.contrast=-1..1
* &s.saturation=-1..1
* &s.invert=true
* &s.roundcorners=radius|topleft,topright,bottomright,bottomleft - 'radius' is a percentage between 0 and 100 of 1/2 the smaller of width and height. You can crop to a circle with `width=x&height=x&mode=crop&s.roundcorners=100`. New in V3.2+

## Examples


![Original image](http://img.imageresizing.net/utah2.jpg;width=200)


### Evenly rounded

`s.roundcorners=30`

![s.roundcorners=30](http://img.imageresizing.net/utah2.jpg;width=200;s.roundcorners=30)

### Specify individual radii

`s.roundcorners=45,0,45,0`

![s.roundcorners=45,0,45,0](http://img.imageresizing.net/utah2.jpg;width=200;s.roundcorners=45,0,45,0)


### 4 ways to grayscale

`s.grayscale`=`true|y|ry|ntsc|bt709|flat`  (true, ntsc, and y produce identical results)

The following examples use NTSC/Y/True, RY, BT709, and Flat respectively

![s.grayscale=true](http://img.imageresizing.net/utah2.jpg;width=200;s.grayscale=true)
![s.grayscale=ry](http://img.imageresizing.net/utah2.jpg;width=200;s.grayscale=ry)
![s.grayscale=bt709](http://img.imageresizing.net/utah2.jpg;width=200;s.grayscale=bt709)
![s.grayscale=flat](http://img.imageresizing.net/utah2.jpg;width=200;s.grayscale=flat)

### 1 way to sepia

`s.sepia=true`

![s.sepia=true](http://img.imageresizing.net/utah2.jpg;width=200;s.sepia=true)

### Inversion

`s.invert=true`

![s.invert=true](http://img.imageresizing.net/utah2.jpg;width=200;s.invert=true)


### Adjust opacity/alpha

`s.alpha`= `0..1`

For true transparency, combine with `format=png`. Otherwise, the image will be blended against `bgcolor`.

![s.alpha=0.25](http://img.imageresizing.net/utah.jpg;width=200;s.alpha=0.25)
![s.alpha=0.75](http://img.imageresizing.net/utah.jpg;width=200;s.alpha=0.75)
![s.alpha=0.85](http://img.imageresizing.net/utah.jpg;width=200;s.alpha=0.85)
![s.alpha=1](http://img.imageresizing.net/utah.jpg;width=200;s.alpha=1)

### Adjust contrast


`s.contrast`= `-1..1`


![s.contrast=-0.80](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=-0.99)
![s.contrast=-0.80](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=-0.80)
![s.contrast=-0.40](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=-0.40)
![s.contrast=-0.20](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=-0.20)

![s.contrast=0](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=0)


![s.contrast=0.20](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=0.20)
![s.contrast=0.40](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=0.40)
![s.contrast=0.80](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=0.80)
![s.contrast=0.99](http://img.imageresizing.net/utah.jpg;width=200;s.contrast=0.99)



### Adjust brightness


`s.brightness`= `-1..1`


![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=-1)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=-0.7)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=-0.5)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=-0.2)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=0)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=0.2)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=0.5)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=0.7)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.brightness=1)

### Adjust saturation


`s.saturation`= `-1..1`



![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=-1)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=-0.9)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=-0.5)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=-0.2)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=0)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=0.2)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=0.5)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=0.9)
![](http://img.imageresizing.net/red-leaf.jpg;width=100;s.saturation=1)


### Legacy syntax (Before v3.1)

* &filter=grayscale
* &filter=sepia (didn't work)
* &filter=brightness(.1) (-1..1) (Change .1 to the brightness offset you want)
* &filter=alpha(.5)   (Change .5 to the alpha multiplier you want)
