(function($){

  $.fn.twentytwenty = function(options) {
    var options = $.extend({default_offset_pct: 0.5}, options);
    return this.each(function() {

      var sliderPct = options.default_offset_pct;
      var container = $(this);
      
      container.wrap("<div class='twentytwenty-wrapper'></div>");
      container.append("<div class='twentytwenty-overlay'></div>");
      var beforeImg = container.find("img:first");
      var afterImg = container.find("img:last");
      container.append("<div class='twentytwenty-handle'></div>");
      var slider = container.find(".twentytwenty-handle");
      slider.append("<span class='twentytwenty-left-arrow'></span>");
      slider.append("<span class='twentytwenty-right-arrow'></span>");
      container.addClass("twentytwenty-container");
      beforeImg.addClass("twentytwenty-before");
      afterImg.addClass("twentytwenty-after");
      
      var overlay = container.find(".twentytwenty-overlay");
      overlay.append("<div class='twentytwenty-before-label'></div>");
      overlay.append("<div class='twentytwenty-after-label'></div>");

      var calcOffset = function(widthPct) {
        var w = beforeImg.width();
        var h = beforeImg.height();
        return {
          w: w+"px",
          h: h+"px",
          cw: (widthPct*w)+"px"
        };
      };

      var adjustContainer = function(offset) {
        beforeImg.css("clip", "rect(0,"+offset.cw+","+offset.h+",0)");
        container.css("height", offset.h);
      };

      var adjustSlider = function(pct) {
        var offset = calcOffset(pct);
        //slider.css("height", offset.h);
        slider.css("left", offset.cw);
        adjustContainer(offset);
      }

      $(window).on("resize.twentytwenty", function(e) {
        adjustSlider(sliderPct);
      });

      var offsetX = 0;
      var imgWidth = 0;
      
      container.on("movestart", function(e) {
        if ((e.distX > e.distY && e.distX < -e.distY) || (e.distX < e.distY && e.distX > -e.distY)) {
          e.preventDefault();
        }
        container.addClass("active");
        offsetX = container.offset().left;
        imgWidth = beforeImg.width();          
      });

      container.on("moveend", function(e) {
        container.removeClass("active");
      });

      container.on("move", function(e) {
        if (container.hasClass("active")) {
          sliderPct = (e.pageX-offsetX)/imgWidth;
          if (sliderPct < 0) {
            sliderPct = 0;
          }
          if (sliderPct > 1) {
            sliderPct = 1;
          }
          adjustSlider(sliderPct);
        }
      });

      container.find("img").on("mousedown", function(e) {
        event.preventDefault();
      });

      $(window).trigger("resize.twentytwenty");
    });
  };

})(jQuery);
// for default page load, to overcome script defer tag $ not defined error
$(window).load(function(){
  $(".twentytwenty-container").twentytwenty({default_offset_pct: 0.5});
});

// for buttons
$(document).ready( function() {
  $(".plugin-example-button").click(function() {
    var image_before = $(this).attr('data-image-before');
    var image_after = $(this).attr('data-image-after');
    // prevent fade out if it is the same image
    if ( $("#plugin-example-before").attr("src") !== image_before ) {
      $("#plugin-example-before").fadeOut(50, function() { 
        $(this).load(function() { 
          $(this).delay(150);
          $(this).fadeIn(700); 
        }); 
        $(this).attr("src", image_before); 
      });
      $("#plugin-example-after").fadeOut(50, function() { 
        $(this).load(function() { 
          $(this).delay(150);
          $(this).fadeIn(700); }); 
        $(this).attr("src", image_after); 
      }); 
    }
  });
  // before
  $("input[name=compare-before]").click(function() {
    var newOptions = $(this).val();
    $("#desc-before").text($(this).parent().text());
    // change main image
    var newMainImgSrc = $("#plugin-example-before").attr("src").split("?")[0]
    var newMainImgFullPath = newMainImgSrc + "?" + newOptions
    // prevent fade out if it is the same image
    if ( $("#plugin-example-before").attr("src") !== newMainImgFullPath ) {
      $("#plugin-example-before").fadeOut(50, function() { 
        $(this).load(function() { 
          $(this).delay(150);
          $(this).fadeIn(700); }); 
        $(this).attr("src", newMainImgFullPath); 
      }); 
    }

    $(".plugin-example-button").each(function() {
      var newImgSrc = $(this).attr("data-image-before").split("?")[0];
      var newImgFullPath = newImgSrc + "?" + newOptions
      $(this).attr("data-image-before" ,newImgFullPath);
    });
  });

  // after
  $("input[name=compare-after]").click(function() {
    var newOptions = $(this).val();
    $("#desc-after").text($(this).parent().text());
  // change main image
  var newMainImgSrc = $("#plugin-example-after").attr("src").split("?")[0]
  var newMainImgFullPath = newMainImgSrc + "?" + newOptions
  // prevent fade out if it is the same image
  if ( $("#plugin-example-after").attr("src") !== newMainImgFullPath ) {
    $("#plugin-example-after").fadeOut(50, function() { 
      $(this).load(function() { 
        $(this).delay(150);
        $(this).fadeIn(700); }); 
      $(this).attr("src", newMainImgFullPath); 
    }); 
  }
  $("#plugin-example-after").attr("src", newMainImgFullPath);
  // set data attributes for thumbnails
  $(".plugin-example-button").each(function() {
    var newImgSrc = $(this).attr("data-image-after").split("?")[0];
    var newImgFullPath = newImgSrc + "?" + newOptions
    $(this).attr("data-image-after" ,newImgFullPath);
  });
  });
});


