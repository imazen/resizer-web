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
  
  if (f["email"].value == "") {
    f["email"].focus();
    alert("The Email field is required.");
    return false;
  }
	return true;
}

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
      if ($.fn.typed){
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
        var imgPath = "https://z.zr.io/ri/u3.jpg?"
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
      }
  });

$(function(){

  var getOptionsFromString = function(str, options){
    console.log(str);
    if (str == "all" || str === undefined || str == null) {
      return options;
    }
    var matches = [];
    if (str.indexOf("contracts") != -1){
      matches = matches.concat(["gold", "silver", "bronze"]);
    }

    for (var i =0; i < options.length; i++){
      if (str.indexOf(options[i]) != -1){
        matches.append(options[i]);
      }
     }
    return matches;
  };


  $(".questions input").click(function(e){
    var options = ["essential", "trial", "performance", "creative", "elite", "silver", "gold", "bronze", "oem"];

    var limits = options.slice();

    $(".questions input").each(function(index){
      var input = $(this);
      console.log(input);
      var checked = input.prop('checked');
      var results = getOptionsFromString(input.data('data-skus'), options);

      limits = limits.filter(function(n) {
          return results.indexOf(n) != -1
      });
      
    });
    alert("Allowed options: " + limits);   
  });
});

