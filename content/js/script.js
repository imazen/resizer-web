window.log = function(){
  log.history = log.history || [];  
  log.history.push(arguments);
  arguments.callee = arguments.callee.caller;  
  if(this.console) console.log( Array.prototype.slice.call(arguments) );
};
(function(b){function c(){}for(var d="assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(","),a;a=d.pop();)b[a]=b[a]||c})(window.console=window.console||{});

window.slimmage = window.slimmage | {};
window.slimmage.verbose = false;


if (window.hljs !== undefined){
hljs.tabReplace = '  '; 
hljs.initHighlightingOnLoad();
}
$(function(){
	if ($(".banners").bxSlider) {
  	$(".banners").bxSlider({
      auto: true,
      pager: true,
  		controls:false,
      pause: 6000
    });
    $("ul.client-logo-carousel").bxSlider({
      slideWidth: 160,
      minSlides: 2,
      maxSlides: 10,
      slideMargin: 10,
      auto: true
    });
      $("ul.website-carousel").bxSlider({
      slideWidth: 200,
      minSlides: 1,
      maxSlides: 10,
      slideMargin: 10,
      auto: true
    });
  }
	/*$('pre code').not('code[class]').each(function(i, e) {$(e).addClass('csharp c-sharp'); hljs.highlightBlock(e, '  ')});*/


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
});


$('a[href*="Resizer3"]').click(function(){
	_gaq.push(['_trackEvent', 'Downloads', 'Releases', $(this).attr('href')]);
	_gaq.push(['_trackPageview', $(this).attr('href') ]);
});

$('a[href*="Resizer2"]').click(function(){
	_gaq.push(['_trackEvent', 'Downloads', 'Releases-v2', $(this).attr('href')]);
	_gaq.push(['_trackPageview', $(this).attr('href') ]);
});


if (typeof(loadq) !== 'undefined'){
	for (var i = 0; i < loadq.length; i++)
		$(loadq[i]);
}
//So e-junkie falls back gracefully.
if (typeof(EJEJC_lc) !== undefined) var EJEJC_lc = function (th) { return false; };

/* Handles signup forms */


function verifyRequired(id) {
  var f = document.getElementById(id);
  if (document.location.protocol === "https:")
  f.action = "https://app.icontact.com/icp/signup.php";
  
  if (f["fields_email"].value == "") {
    f["fields_email"].focus();
    alert("The Email field is required.");
    return false;
  }
	return true;
}


/*function EJEJC_config() {
EJEJC_BEACON = "https://www.googleadservices.com/pagead/conversion/0062225003/?value=1&label=purchase&script=0";
}


$(function(){
  ejGATracker = _gat._getTracker("UA-XXXXX-X");
});
	*/


$(function(){
  var noun = $(".ml_noun");
  setInterval(function(){
    options = ["one", "two", "three"];
    newIndex = Math.floor(Math.random() * 3)

    noun.text(options[newIndex]);
  },1500);
  $(".ml_noun").text()
});


  $(function(){
      var queryStrings = ["height=150", 
                          "w=170&h=170&mode=crop",
                          "w=170&h=170&mode=pad",
                          "w=170&h=170&mode=max",
                          "h=200&s.grayscale=true",
                          "crop=770,590,1170,790",
                          "srotate=90&height=200",
                          "h=200&s.sepia=true"
                          ];
      var img = $('.change-this-image');
      var imgPath = "http://z.zr.io/ri/u3.jpg?"
      $(".home-code-box .type-this").typed({
        strings: queryStrings,
        backDelay:2000,
        loop:true,
        typeSpeed: 50,
        callback: function(){
         
        },
        stringFinished: function(str){
          img.prop('src', imgPath + str);
          //console.log("completed " + imgPath + str)
        }
      });
  });



