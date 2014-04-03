Date: June 7, 2013
Summary: Here's how to use ImageResizer in conjunction with slimmage.js to create responsive images for your webpage.

# Effortless responsive images

Until recently, responsive images have been too complicated and fragile for general purpose use &mdash; despite how *essential* they are for [responsive web design](http://en.wikipedia.org/wiki/Responsive_web_design); without responsive images, mobile devices typically download 2-3x more data than is needed.

**We're introducing a *simple* way to create responsive images** &mdash; without sacrificing maintainability. 

**Your existing CSS breakpoints and `max-width` rules for images will stay in control of client-size scaling (and now, which image version is requested).**

This solution involves 3 components

1. An [RIAPI-compliant](http://riapi.org) RESTful image API such as ImageResizer
2. The super-tiny [Slimmage.js library for responsive images](https://github.com/imazen/slimmage)
3. [SlimResponse](http://github.com/imazen/slimresponse), an HttpModule that generates the HTML needed by Slimmage.js for any `<img class="slimmage" src="image.jpg?width=150/>` tag found in outgoing HTML. You can substitute an HTML helper for SlimResponse if you prefer.

### Step 1. Install ImageResizer and [SlimResponse](http://github.com/imazen/slimresponse)

You can install both via NuGet, or [install ImageResizer](/docs/install) manually followed by [SlimResponse](http://github.com/imazen/slimresponse). The DiskCache plugin is strongly suggested for best performance.


    Install-Package ImageResizer.MvcWebConfig
    Install-Package ImageResizer.DiskCache
    Install-Package Imazen.SlimResponse


Verify your [web.config has both ImageResizer and SlimResponse installed](http://github.com/imazen/slimresponse), and that you can access ImageResizer's self diagnostics page when running your site at `/resizer.debug.ashx`

### Step 2. Install slimmage.js

[Download the latest version of slimmage.js](https://github.com/imazen/slimmage) and include it in your site-wide javascript, or at minimum on all pages for which you need responsive images. 

Slimmage.js is a tiny (1.41KB compressed & minified) vanilla javascript library that enables responsive images with fanastic cross-browser support. [More deatils on its project page](https://github.com/imazen/slimmage).

### Step 3. Annotate which images you want to be responsive


SlimResponse looks through outgoing HTML for `<img>` tags with a `slimmage` class applied, such as 


    <img class="slimmage" src="image.jpg?width=150&quality=90" />

    <img class="thisclass slimmage thatclass" src="image.jpg?width=150&quality=90" />


or for "slimmage=true" in any image URL

    <img src="image.jpg?width=150&slimmage=true&quality=90" />

As [mentioned in the slimmage.js documentation](https://github.com/imazen/slimmage), you *MUST* include the `width=value` command for Slimmage to modify the value. If you want automatic quality adjustment, you also need to include `quality=90` in the image URL.


You can [download the SlimResponse project](https://github.com/imazen/slimresponse/archive/master.zip) and run the 'www' website for a simple demo of this functionality in action.

The slimage.js project [offers a more interesting live demo](http://imazen.github.io/slimmage/demo.html).




