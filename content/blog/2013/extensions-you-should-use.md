Date: January 28, 2013

# Try 3 new third-party extensions; get $5 if you find a bug

**Try these extensions before Feb. 15th, 2013 and get paid for any bugs you find!** Details at bottom of page.
 
## [ImageResizer.FluentExtensions](https://github.com/benfoster/ImageResizer.FluentExtensions) by [Ben Foster](https://github.com/benfoster)
 
 
Tired of ResizeSettings or querystrings? Use this amazing fluent API instead:
 
    new ImageUrlBuilder()
        .Resize(img => img.Dimensions(400, 300).Crop())
        .Transform(img => img.FlipAfter(FlipType.X))
        .Output(img => img.Quality(90).Format(OutputFormat.Jpeg))
        .BuildUrl("image.jpg")
     
    -> /image.jpg?width=400&height=300&mode=crop _
        &flip=x&quality=90&format=jpg

If you find a severe bug in this library, we'll send you $10 instead of $5.
 
[View Project](https://github.com/benfoster/ImageResizer.FluentExtensions)  [Download Zip](https://github.com/benfoster/ImageResizer.FluentExtensions/archive/master.zip)

 
## [ImageResizer-ResponsivePresets](https://github.com/mindrevolution/ImageResizer-ResponsivePresets) by [marc303](https://github.com/marc303)
 
Want an effortless, all-in-one solution to your responsive imaging needs? 
 
This project offers HTML filtering, compliance with the HTML5 picture element draft, flexible presets, and a prefetcher-safe polyfill.
 
You've been lagging behind the curve with responsive design; this project can help you get back on track.
 
[View Project](https://github.com/mindrevolution/ImageResizer-ResponsivePresets)  [Download Zip](https://github.com/mindrevolution/ImageResizer-ResponsivePresets/archive/master.zip)


## [StudioJS](https://github.com/imazen/studiojs) 
 
A UI for ImageResizer, implemented as a fast jQuery plugin.
 
It covers nearly 10% of the ImageResizer commands, effects,  and plugins, and is easy to extend.
 
Here's what's already implemented:
 
* Rotate & Flip
* Crop & Recrop
* Adjust saturation, contrast, and brightness
* Adjust white balance
* Noise removal
* Smart sharpening
* Eye detection and red eye correction (not enabled in demo)
* Face detection and selection (not enabled in demo)
* Blur, Posterize, Oil Painting
* It's open-source, and we accept patches. Please fork and contribute!
 
[View Project](https://github.com/imazen/studiojs)  [Download Zip](https://github.com/imazen/studiojs/archive/master.zip)

## Free support rules

Imazen is providing free support for these third-party libraries until Feb. 15th, 2013. Support requests may *only* be made through the `Issues` page on each project, so everyone can benefit. E-mails will be ignored.


## Bug reward program

All 3 projects are eligible for the $5 USD reward. Severe bugs in FluentExtensions are eligible for a $10 reward.

To receive the reward, you must be the first person to report the issue (check the Issues page!), and you must report it before Feb. 15th 2013.

Payments can only be made via PayPal.

This bug-bounty and free support time is being sponsored and provided by Imazen, not the individual plugin authors (although they'll probably help with support as well).


