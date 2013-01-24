Bundle: 1
Edition: performance
Tagline: Get rid of ugly .NET GIFs, and get photoshop-like results for GIFs and 8-bit PNG images. Uses tuned octree quantization and smart, adjustable dithering.

# PrettyGifs plugin

Replaces .NET's disgusting default GIF encoding algorithm with Octree quantization and dithering, and allows 8-bit PNG creation. Compatible with all plugins.

## Installation

Either run `Install-Package ImageResizer.Plugins.PrettyGifs` in the NuGet package manager, or:

1. Add ImageResizer.Plugins.PrettyGifs to your project
2. Add `<add name="PrettyGifs" />` inside `<resizer><plugins></plugins></resizer>` in Web.config.

## Supported querystring commands

* colors=2-256
* dither=true|4pass
* preservePalette=true|false - If true, will attempt to use the original palette if present instead of recalculating it. 


## Why not [nQuant](http://nquant.codeplex.com/)? 


A) On an informal test, it was 10x slower than the Octree algorithm on a 256x256 PNG. I.e, 1900ms vs 195ms. It also took 80MB of ram, while Octree took kilobytes.
B) It intrinsically requires 50MB ((32^4)x(6x8)=50,331,648 bytes) of ram per encode *just to store the histogram information for any size file*. This is an intrinsic limitation of [any implementation of Xiaolin Wu's color quantizer](http://www.ece.mcmaster.ca/~xwu/cq.c). Versus kilobytes for the Octree algorithm.
C) Only works for PNG files, it's designed for a multi-bit alpha channel. I could fix that, though.
D) The nQuant implementation also makes excessive copies of the image, making it scale poorly. For example, on a 1300x840 PNG, nuQuant took 18.8 seconds and 110-130MB of ram, while Octree took 0.3 seconds and 4-8MB of RAM. This is also fixable, I believe. 



http://pngnq.sourceforge.net/index.html 
http://members.ozemail.com.au/~dekker/NEUQUANT.HTML
