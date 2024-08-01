---
:append: edition_info
:tags: plugin
:edition: creative
:tagline: Preserve metadata during image processing.
:aliases: "/plugins/copymetadata"
:edit_info: develop/plugins/copymetadata/readme.md
---

# CopyMetadata plugin

**Warning. This plugin can only *copy* metadata, not read, or return it. It will be replaced in V4 with a more capable plugin.** 

Copies all metadata from the source image to the destination image. 

Metadata specific to original encoding of image (like width, height, etc), is of course discarded and replaced. See [the source for a comprehensive list of discarded metadata](https://github.com/imazen/resizer/blob/master/Plugins/CopyMetadata/CopyMetadataPlugin.cs#L68).

## Installation

Install `ImageResizer.Plugins.CopyMetadata`, *or*...

1. Reference ImageResizer.Plugins.CopyMetadata.dll
2. Add `<add name="CopyMetadata" />` to the `<plugins />` section.

## Syntax

* `copymetadata=true`


### Resources

http://stackoverflow.com/a/25162782/166893
https://msdn.microsoft.com/en-us/library/system.drawing.imaging.propertyitem.id.aspx