Bundle: 1
Edition: performance
Tagline: Get rid of ugly .NET GIFs, and get photoshop-like results for GIFs and 8-bit PNG images. Uses tuned octree quantization and smart, adjustable dithering.
Libs: jquery.event.move, jquery.twentytwenty


<style type="text/css" media="screen">
.twentytwenty-handle:before, .twentytwenty-handle:after {content: " "; display: block; width: 3px; background: white; height: 9999px; position: absolute; left: 50%; margin-left: -1.5px; z-index: 30; -webkit-box-shadow: 0px 0px 12px rgba(51, 51, 51, 0.5); -moz-box-shadow: 0px 0px 12px rgba(51, 51, 51, 0.5); box-shadow: 0px 0px 12px rgba(51, 51, 51, 0.5); } .twentytwenty-before-label, .twentytwenty-after-label, .twentytwenty-overlay {position: absolute; top: 0; width: 100%; height: 100%; } .twentytwenty-before-label, .twentytwenty-after-label, .twentytwenty-overlay {-webkit-transition-duration: 0.5s; -moz-transition-duration: 0.5s; transition-duration: 0.5s; } .twentytwenty-before-label, .twentytwenty-after-label {-webkit-transition-property: opacity; -moz-transition-property: opacity; transition-property: opacity; } .twentytwenty-before-label:before, .twentytwenty-after-label:before {color: white; font-size: 13px; letter-spacing: 0.1em; } .twentytwenty-before-label:before, .twentytwenty-after-label:before {background: rgba(255, 255, 255, 0.2); position: absolute; top: 50%; margin-top: -19px; line-height: 38px; padding: 0 20px; -webkit-border-radius: 2px; -moz-border-radius: 2px; border-radius: 2px; } .twentytwenty-left-arrow, .twentytwenty-right-arrow {width: 0; height: 0; border: 6px inset transparent; position: absolute; top: 50%; margin-top: -6px; } .twentytwenty-container {-webkit-box-sizing: content-box; -moz-box-sizing: content-box; box-sizing: content-box; overflow: hidden; position: relative; -webkit-user-select: none; -moz-user-select: none; } .twentytwenty-container img {position: absolute; top: 0; display: block; } .twentytwenty-container.active .twentytwenty-overlay, .twentytwenty-container.active :hover.twentytwenty-overlay {background: rgba(0, 0, 0, 0); } .twentytwenty-container.active .twentytwenty-overlay .twentytwenty-before-label, .twentytwenty-container.active .twentytwenty-overlay .twentytwenty-after-label, .twentytwenty-container.active :hover.twentytwenty-overlay .twentytwenty-before-label, .twentytwenty-container.active :hover.twentytwenty-overlay .twentytwenty-after-label {opacity: 0; } .twentytwenty-container * {-webkit-box-sizing: content-box; -moz-box-sizing: content-box; box-sizing: content-box; } .twentytwenty-before-label {opacity: 0; } .twentytwenty-before-label:before {content: "Before"; left: 10px; } .twentytwenty-after-label {opacity: 0; } .twentytwenty-after-label:before {content: "After"; right: 10px; } .twentytwenty-overlay {-webkit-transition-property: background; -moz-transition-property: background; transition-property: background; background: rgba(0, 0, 0, 0); z-index: 25; } .twentytwenty-overlay:hover {background: rgba(0, 0, 0, 0.5); } .twentytwenty-overlay:hover .twentytwenty-after-label {opacity: 1; } .twentytwenty-overlay:hover .twentytwenty-before-label {opacity: 1; } .twentytwenty-before {z-index: 20; } .twentytwenty-after {z-index: 10; } .twentytwenty-handle {height: 38px; width: 38px; position: absolute; left: 50%; top: 50%; margin-left: -22px; margin-top: -22px; border: 3px solid white; -webkit-border-radius: 1000px; -moz-border-radius: 1000px; border-radius: 1000px; -webkit-box-shadow: 0px 0px 12px rgba(51, 51, 51, 0.5); -moz-box-shadow: 0px 0px 12px rgba(51, 51, 51, 0.5); box-shadow: 0px 0px 12px rgba(51, 51, 51, 0.5); z-index: 40; } .twentytwenty-handle:before {bottom: 50%; margin-bottom: 22px; -webkit-box-shadow: 0 3px 0 white, 0px 0px 12px rgba(51, 51, 51, 0.5); -moz-box-shadow: 0 3px 0 white, 0px 0px 12px rgba(51, 51, 51, 0.5); box-shadow: 0 3px 0 white, 0px 0px 12px rgba(51, 51, 51, 0.5); } .twentytwenty-handle:after {top: 50%; margin-top: 22px; -webkit-box-shadow: 0 -3px 0 white, 0px 0px 12px rgba(51, 51, 51, 0.5); -moz-box-shadow: 0 -3px 0 white, 0px 0px 12px rgba(51, 51, 51, 0.5); box-shadow: 0 -3px 0 white, 0px 0px 12px rgba(51, 51, 51, 0.5); } .twentytwenty-left-arrow {border-right: 6px solid white; left: 50%; margin-left: -17px; } .twentytwenty-right-arrow {border-left: 6px solid white; right: 50%; margin-right: -17px; }
</style>

<div class="twentytwenty-container">
  <img src="http://z.zr.io/rw/pluginexamples/sunflower-websafe-ps.gif" />
  <img src="http://z.zr.io/rw/pluginexamples/sunflower.jpg?format=gif&colors=216&dither=4pass&preservePalette=false" />
</div>

*Before/Left:* Simulated 216 Web Pallette

*After/Right:* PrettyGifs format = gif, colors = 216, dither = 4pass, preservePalette = false

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


<script>
$(window).load(function(){
	$(".twentytwenty-container").twentytwenty({default_offset_pct: 0.3});  
});
</script>

