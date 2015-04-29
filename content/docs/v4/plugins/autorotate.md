---
:append: edition_info
:tags: plugin
:bundle: free
:edition: free
:tagline: Use the EXIF rotation data from the camera to auto-rotate your images.
:aliases: "/plugins/autorotate"
:edit_info: develop/core/plugins/basic/autorotate_readme.md
---

# AutoRotate plugin (v3.1+)

Automatically rotates images based on the EXIF Orientation flag embedded by the camera. 

## Installation

1. Add `<add name="AutoRotate" />` to the `<plugins />` section.

## Syntax

Add `&autorotate=true` to any image url.