---
:append: edition_info
:tags: plugin
:bundle: free
:edition: free
:tagline: Use the Exif rotation data from the camera to auto-rotate your images.
:aliases: "/plugins/autorotate"
:edit_info: develop/core/plugins/basic/autorotate_readme.md
---

# Rotate images by Exif data

Automatically rotate images based on the Exif Orientation flag embedded by the camera.

## Enable autorotation for all images by default via Web.config

            <pipeline defaultCommands="autorotate.default=true" />


The default is "false"

## Via URL 

`&autorotate=false` or `&autorotate=true` will override the default. 


### Historical note

ImageResizer v4 has subsumed AutoRotate into the core; it is no longer a plugin.