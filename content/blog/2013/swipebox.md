Date: June 1 2013
Libs: swipebox

# Responsive, touch-friendly lightboxes with ImageResizer and SwipeBox

There are few things more frustrating than wrestling with a lightbox widget on your mobile phone. If you're lucky, you'll see the first image; if you're not, you'll get an unresponsive black div and be forced to reload the page.

[SwipeBox](http://brutaldesign.github.io/swipebox/) has a few flaws (it doesn't preload images, and it doesn't support pinch-to-zoom), but it's otherwise a very decent (and extremely small!) jQuery plugin that's designed to be mobile-friendly and responsive.

We're going to combine SwipeBox with ImageResizer, and serve device-tailored full-screen images to eliminate bandwidth waste. We'll limit the number of size variations to 13 to keep the cache waste down.


### Ingredients

* jQuery 1.9+ 
* SwipeBox
* SwipeBox CSS
* HTML Images wrapped in hyperlinks
* The loading command



### The example


    <!DOCTYPE HTML>
    <html lang="en-US">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width; initial-scale=1.0"/>
      <link rel="stylesheet" href="/css/swipebox.css">
    </head>
    <body>

    <div class="box">
      <a href="http://z.zr.io/ri/3s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Harbor">
        <img src="http://z.zr.io/ri/3s.jpg?width=200&height=200" alt="Harbor">
      </a>
    </div>
    <div class="box">
      <a href="http://z.zr.io/ri/4s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Sunset">
        <img src="http://z.zr.io/ri/4s.jpg?width=200&height=200" alt="Sunset">
      </a>
    </div>
    <div class="box">
      <a href="http://z.zr.io/ri/5s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Summer">
        <img src="http://z.zr.io/ri/5s.jpg?width=200&height=200" alt="Summer">
      </a>
    </div>
    <div class="box">
      <a href="http://z.zr.io/ri/8s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Dolomites">
        <img src="http://z.zr.io/ri/8s.jpg?width=200&height=200" alt="Dolomites">
      </a>
    </div>

      <script src="lib/jquery-1.9.0.min.js"></script>
      <script src="lib/ios-orientationchange-fix.js"></script>
      <script src="source/jquery.swipebox.min.js"></script>
      <script type="text/javascript">
        if ($.fn.swipebox) {

          //Let's find out the viewport size in device pixels
          var vw = document.documentElement.clientWidth;
          var vh = document.documentElement.clientHeight;
          if (window.devicePixelRatio){
            vw *= window.devicePixelRatio;
            vh *= window.devicePixelRatio;
          }

          //We don't want to be orientation-specific
          var maxSize = Math.max(vw,vh);

          maxSize = Math.min(2048,maxSize); //Limit size to 2048.

          //Minimize variants for caching improvements; round up to nearest multiple of 160
          maxSize = maxSize - (maxSize % 160) + 160; //Will limit to 13 variations

          //Set the width and height (if present) to maxSize
          $("a.swipebox").each(function(i,e){
              e.href = e.href.replace(/width=\d+/,"width=" + maxSize).replace(/height=\d+/,"height=" + maxSize);
            });
          //Launch swipebox
          $(".swipebox").swipebox({useCSS:true, hideBarsDelay:0});
        }
      </script>
    </body>
    </html>

### The demo

<style type="text/css">
  .box {
  float: left;
  margin-bottom: 0.7em;
  text-align: center;
}
.box .swipebox {
  display: block;
}

</style>

<div class="box">
  <a href="http://z.zr.io/ri/3s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Harbor">
    <img src="http://z.zr.io/ri/3s.jpg?width=200&height=200" alt="Harbor">
  </a>
</div>
<div class="box">
  <a href="http://z.zr.io/ri/4s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Sunset">
    <img src="http://z.zr.io/ri/4s.jpg?width=200&height=200" alt="Sunset">
  </a>
</div>
<div class="box">
  <a href="http://z.zr.io/ri/5s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Summer">
    <img src="http://z.zr.io/ri/5s.jpg?width=200&height=200" alt="Summer">
  </a>
</div>
<div class="box">
  <a href="http://z.zr.io/ri/8s.jpg?width=1200&height=1200&mode=max&quality=85" class="swipebox" title="Dolomites">
    <img src="http://z.zr.io/ri/8s.jpg?width=200&height=200" alt="Dolomites">
  </a>
</div>