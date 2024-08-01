---
:append: edition_info
:tags: plugin
:aliases: []
:edition: elite
:tagline: Adds support for PSD source files.
:edit_info: support/v3/plugins/psdreader/readme.md
:flags:
- "-sitemap"
---

# PsdReader plugin

Adds support for .PSD source files. No configuration required.

Transparent PSD files will be displayed with a white background. For transparency support for PSDs, see [FreeImageDecoder](/plugins/freeimage).

## Installation

Either run `Install-Package ImageResizer.Plugins.PsdReader` in the NuGet package manager, or:

1. Add ImageResizer.Plugins.PsdReader.dll to your project
2. Add `<add name="PsdReader" />` inside `<resizer><plugins></plugins></resizer>` in Web.config.

## Usage

Simply reference a .psd file as you would a .jpg

    image.psd?width=100

A 100px wide jpeg will be returned. 

You can also simply convert the image to another format.

    image.psd?format=png
    image.psd?format=jpg