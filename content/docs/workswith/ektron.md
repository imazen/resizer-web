Tags: cms


# Ektron includes ImageResizer

Ektron 8.6 and higher include ImageResizer Essential Edition, but do not register the HttpHandler properly. This means `ImageResizer.dll` may already be installed in `/bin`, but you will still have to modify `Web.config`.

Follow standard installation instructions. If you get an assembly binding error, you may need to upgrade to a newer release of Ektron (Ektron 8.6 uses a version-specific assembly reference to ImageResizer; this should be fixed in later releases).