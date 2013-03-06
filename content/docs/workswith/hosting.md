Layout: install_page

# Hosting Providers

Any hosting provider will work, but many restrict ASP.NET permissions to the point where some external plugins can't run. Others just restrict (or don't provide enough) bandwidth, making image serving unbearably slow. 

Here's a few we've worked with.

* DiscountASP (100% compatible, but limited download bandwidth speed)
* MaximumASP (100% compatible, great company, great support)
* WebHost4Life (100% compatible,  but *very* limited download bandwidth speed. You must make support enable wildcard mapping, you can't do it through the control panel)
* RackSpace (RackSpace enforces very strict and highly erratic customized trust levels that can disable most plugins. However, some plans allow for full trust or allow you to fix their medium trust configuration. If you're getting a dedicated or virtual server, you'll probably be fine). If you're already stuck with RackSpace, I can still help you make the best of the situation, just contact support@imageresizing.net.
* Amazon EC2 (100% compatible, my personal choice)

We've also received success stories about dozens of other ISPs from hundreds of users. 

If your provider doesn't allow Full Trust, you may not be able to run the PrettyGifs plugin or some of the advanced plugins in the Creative edition, but all the core functionality should work fine. The Watermark and SimpleFilters will even work in low trust, so the Creative Edition can still be useful in that situation.

So far, we have  been able to resolve every ISP-related compatibility problem we've been notified of (excluding trust level limtations for advanced plugins, of course).

