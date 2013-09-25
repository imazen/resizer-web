Date: June 2 2013
Flags: hidden

# Responsive Images Today

Responsive images are arguably the hardest part of modern web development. Browser vendors have thwarted our valiant efforts dozens of times, introducing race conditions, implementing mostly un-bypassable prefetching systems, and (we suspect) laughing maniacally whenever a new solution appears. It's driven most of us to tears.

We have some solutions that *appear* future-friendly, but they all have flaws. 

1. Server-side viewport estimation relies on user-agent data, taking CDNs off the table (unless you use cross-domain redirects). There's a [HTTP Client Hints](http://tools.ietf.org/html/draft-grigorik-http-client-hints-00) proposal on the table to make this better ([great presentation here](http://bit.ly/client-hints-w3cperf)), but it could be years before it's widespread enough to rely on.
2. Javascript-only solutions cause 2 requests; images are prefetched before javascript can modify 'src'.
3. Markup-based solutions can prevent 2 requests, but often require a dozen lines or more, and the accessibility story is not that great.

Adding insult to injury - all the current solutions depend on viewport size - not context size, meaning the markup needs to know what percentage of the screen the image is supposed to fill. 

## A simpler solution with ImageResizer (or any [RIAPI](http://riapi.org)-compliant module)

While the W3C must find a client-side solution, users of ImageResizer are under no such restrictions. 

For gradeful degredation, we must ensure that an image still displays when javascript is turned off. 
For performance, we must prevent duplicate requests.

The &lt;noscript> tag can solve both of these challenges... when accompanied by a little javascript.

    <noscript data-ri>
      <img src="http://z.zr.io/ri/1s.jpg?width=150" />
    </noscript>





https://github.com/eeeps/scalables

http://ericportis.com/posts/2013/scalables/


## What we need from browser vendors immediately

*Immediately give us an attribute that can disable prefetching on images (or better yet, any type of reference).*

https://dvcs.w3.org/hg/webperf/raw-file/tip/specs/ResourcePriorities/Overview.html

https://www.w3.org/Bugs/Public/show_bug.cgi?id=17842



## Further Reading

http://blog.cloudfour.com/8-guidelines-and-1-rule-for-responsive-images/

http://www.brucelawson.co.uk/2013/responsive-images-intrerim-report/

http://mobile.smashingmagazine.com/2013/05/10/how-to-avoid-duplicate-downloads-in-responsive-images/

http://mobile.smashingmagazine.com/2013/05/29/the-state-of-responsive-web-design/

http://mobile.smashingmagazine.com/2013/04/09/improve-mobile-support-with-server-side-enhanced-responsive-design/

http://tools.ietf.org/html/draft-grigorik-http-client-hints-00

http://bit.ly/client-hints-w3cperf

http://24ways.org/2012/responsive-images-what-we-thought-we-needed/


http://blog.cloudfour.com/responsive-imgs/
http://blog.cloudfour.com/responsive-imgs-part-2/
http://blog.cloudfour.com/responsive-imgs-part-3-future-of-the-img-tag/

http://alistapart.com/article/responsive-images-how-they-almost-worked-and-what-we-need