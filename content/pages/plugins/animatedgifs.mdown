Tags: plugin
Bundle: 1

# AnimatedGifs plugin

Adds support for resizing animated gifs. Once added, animated gifs will be resized while maintaining all animated frames. By default, .NET only saves the first frame of the GIF image.

Best used with disk caching, as large animations can take a while to process (sometimes even over a second).

## Installation

Either run `Install-Package ImageResizer.Plugins.AnimatedGifs` in the NuGet package manager, or:

1. Add ImageResizer.Plugins.AnimatedGifs to your project
2. Add `<add name="AnimatedGifs" />` inside `<resizer><plugins></plugins></resizer>` in Web.config.
