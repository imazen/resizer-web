Tags: cms

# Sitecore and ImageResizer

Standard installation steps work with SiteCore, but you *cannot use the jpg.ashx syntax* - so ensure you're using IIS integrated mode. All functionality should be accessible with the normal, non-suffixed syntax (`/resizer.debug`, `/image.jpg?width=100`).