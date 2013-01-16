Flags: hidden

# Migrating from ImageGen


image.jpg?width=100&crop=10,10,300,300&rotate=30&scale=both&mode=pad&margin=100

## Similarities

* Both 

## Advantages of ImageResizing.NET

* Implemented as an HttpModule instead of an HttpHandler, allowing far better performance (see [my podcast with Scott Hanselman](http://hanselminutes.com/313/deep-inside-image-resizing-and-scaling-with-aspnet-and-iis-with-imageresizingnet-author-na) for more info).

* Supports medium trust. Advanced features which require full trust are implemented as optional plugins.

* Cropping, flipping, mirroring, rotation, max/min image sizes, predefined classes, and client-side caching are all free features.

* Much cleaner URL syntax. `http://localhost/ImageGen.ashx?image=beautiful.jpg&width=320` vs `http://localhost/beautiful.jpg?width=320`

* DRM-free licensing available.

* A larger community, with 40+ plugins. Easy to extend and customize. 

* Open-source. Download and make changes if you need to.

## Advantages of ImageGen

* DiskCaching is a Basic feature. ImageResizing.NET offers disk caching and Amazon CloudFront support as paid plugins instead.

* Offers BMP and TIFF output. ImageResizing.NET doesn't allow these as output formats, as they're not web-friendly. 

* ImageResizing.NET doesn't provide built-in text generation. The [Watermark plugin handles that separately](/plugins/watermark), and is a paid plugin.

* Easy mapping of folders to presets. This feature hasn't yet been released for the ImageResizing.net project, but *is* easy to implement yourself. 



http://imageresizing.net/docs/reference

## Command table (ImageGen -> ImageResizer)

* `Align (text)` - N/A, specific to text generation
* `VAlign (text)` - N/A, specific to text generation
* `AntiAlias` - N/A, specific to text generation
* `Font` - N/A
* `FontColor` - N/A
* `FontSize` - N/A
* `FontStyle` - N/A
* `LineHeight` - N/A
* `Text` - N/A

* `Align (image)` - Use `anchor=topleft|topcenter|topright|middleleft| middlecenter|middleright|bottomleft|bottomcenter|bottomright` instead.
* `VAlign (image)` - See above.
* `AllowUpSizing=true` equates to `scale=both`. AllowUpSizing=False equates to `scale=down`, the default. 
* `AltBrowser` - Png->GIF fallback handled with the [free IEPngFix plugin](/plugins/iepngfix)
* `AltImage` - 404 fallbacks handled with the [free Image404 plugin](/plugins/image404)
* `BGCOLOR` - Identical to `bgcolor` in the image resizer. Defaults to transparent on PNG or GIF output images, white on jpegs. 
* `Border` - Equivalent to `borderWidth`, except negative border widths don't crop. Use `crop=10,10,-10,-10` if you want to crop a fixed width off.
* `BorderColor` - Identical to `borderColor`
* `Class` - Identical to `preset`. See [the free Presets plugin](/plugins/presets). `OverridesQueryString=True` is equivalent to using the `settings` attribute instead of `defaults` when configuring Presets. 

* `ImageBaseDir` - Not offered by the ImageResizing.Net project, although easily implemented using the Config.Current.Rewrite event.
* `CachingTimeSpan` - Identical to [`<clientcache minutes="" />`](http://imageresizing.net/plugins/clientcache).
* `COLORMODE` - Equates to `s.sepia=true`, `s.grayscale=true`, etc with [the SimpleFilters plugin](http://imageresizing.net/plugins/simplefilters).
* `Compression` - Identical to `quality=0..100`
* `Constrain` - `Constrain=False` equates to `mode=stretch`. 
* `Crop=x,y,w,h` - Similar to `Crop=x,y,x2,y2`. Just add x+w and y+h to get x2 and y2.
* `Crop=resize` - Identical to 'mode=crop' when `width` and `height` are specified. 
* `Crop=noresize` - Use `Crop=0,0,w,h`, `crop=-w,-h,0,0`, etc. to match behavior. I have no idea in what situations this would be used.
* `Flip` - Identical to `flip`. To flip the image *prior* to processing instead of flipping the result, use `sflip=x|y|xy` instead.
* `Format` - Identical to `format=jpg|png|gif`. BMP and TIFF are not supported output formats, as they are not web appropriate.
* `Transparent` - Defaults to true if the output format is png or gif, false if 'jpg' or if 'bgcolor' has been specified.
* `Pad=True` - Identical to `mode=pad`, the default when `width` and `height` are specified. 
* `Height` - Identical to `height`. Usage infers `mode=pad`. Use `maxheight` to infer `mode=max`.
* `Image` - The image path is specified differently in ImageResizer. Commands are appended to the querystring of the regular image URL. No equivalent for {first} or {random} exists - you have to do that elsewhere.
* `nocache` - Equivalent to `cache=no`.
* `overlayimage` - Equivalent to `watermark`. See the [Watermark plugin documentation](/plugins/watermark) for details. Much more flexible than ImageGen.
* `overlaymargin` - See above
* `rotate` - Identical to `rotate`.
* `RemoteDomainWhiteList` - Convert to <resizer><remotereader><allow domain="*.website.com" /><allow regex="expression" /></remotereader></resizer>

