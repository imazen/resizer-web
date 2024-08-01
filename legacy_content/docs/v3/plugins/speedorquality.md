---
:append: edition_info
:tags: plugin
:bundle: free
:edition: free
:tagline: Gain a 15-30% speed boost by sacrificing rendering quality.
:aliases: []
:edit_info: support/v3/core/plugins/basic/speedorquality_readme.md
:flags:
- "-sitemap"
---

# SpeedOrQuality (v3.1+)

Gain a 15-30% speed boost by sacrificing rendering quality.


## Installation

1. Add `<add name="SpeedOrQuality" />` to the `<plugins>` section.


## Usage

Add `&speed=value` to any image URL. 

Value chart

* 0 - Highest quality
* 1 - High quality bilinear, but with low quality pixel offset, smoothing, composing, and compositing quality.
* 2 - Low quality bilinear
* 3 - GetThumbnailImage() is used. This can produce extremely bad (but instant) results when an image has an embedded EXIF thumbnail (most cameras embed these).

## Notes

Resizing is usually the least expensive part of image resizing - jpeg decoding and encoding take most of the time. This plugin can sometimes speed up resizing by 1.5-3x (or more if there is a thumbnail image and you are using &speed=3), but it probably doesn't matter much - the overall savings are likely less than 20%.