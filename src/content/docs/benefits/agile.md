---
title: "Single-Source Imaging"
description: "Store one original, generate every size on demand. Eliminate manual image processing, duplicated files, and human error."
---

## The problem

Every time your site needs a new image size, someone has to open Photoshop, "Save for Web," and upload the result. Multiply that across hundreds or thousands of images, and you get:

- **Wasted hours.** Employees resize images by hand instead of doing real work.
- **Duplicated files.** Five sizes of the same photo means five files to track, store, and update.
- **Human error.** Wrong dimensions, wrong compression, wrong crop. Every manual step is a chance to get it wrong.
- **Brittleness.** Change your layout? Redesign your thumbnails? You get to re-export everything.

This is how most organizations handle images. It's slow, expensive, and fragile.

## The solution: single-source imaging

Store one high-resolution original. Derive every variant on demand through a URL.

```
/photos/product.jpg?width=800&height=600&mode=crop
/photos/product.jpg?width=150&height=150&mode=crop
/photos/product.jpg?width=1200&format=webp&quality=80
```

Same source file. Three different outputs. No Photoshop. No export step. No duplicate files.

ImageResizer generates the requested variant, caches it to disk, and serves it at IIS kernel-cache speed on subsequent requests. Your server can prepare images 50,000 times faster than a human with "Save for Web."

## What you gain

### Eliminate duplication

One file per image. Period. No more `product_thumb.jpg`, `product_medium.jpg`, `product_large.jpg` cluttering your storage and confusing your CMS.

### Eliminate human error

The URL is the spec. If the URL says `width=300&mode=crop`, that's what you get — every time, on every image. No one can accidentally export at the wrong size or forget to optimize.

### Future-proof your assets

Redesigning? Just change the URLs. Your originals don't move. Add responsive breakpoints, switch to WebP, change crop ratios — all without touching a single source file.

### Free your team

Designers design. Developers develop. Neither spends their afternoon batch-resizing product photos. The server handles it — and it's faster at the job than any human.

### Scale without pain

Whether you have 100 images or 100,000, the workflow is the same: upload the original, construct the URL. ImageResizer handles the rest. Add a CDN in front and you're serving millions of variants without breaking a sweat.

## The responsive web demands it

"Save for Web" was designed for a world with one screen size. That world is gone.

Today's sites serve different images to phones, tablets, laptops, retina displays, and slow connections. That's not two sizes — it's a matrix of widths, pixel densities, and formats.

You can't maintain that matrix by hand. Single-source imaging with on-demand processing is the only approach that scales.
