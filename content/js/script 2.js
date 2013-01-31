(function(){
		$("#back-top").hide();
		$(function(){
			$(window).scroll(function(){
				if($(this).scrollTop()>100){
					$("#back-top").fadeIn()
					}else{
						$("#back-top").fadeOut()
						}
				});
				$("#back-top a").click(function(){
					$("body,html").animate({
						scrollTop:0},800);
						return false
				});
		});
	//FCS Carousel Sliders
	$('.fcsCarousel').fcsCarousel({
		speed: 700,
		//autoplay: true,
	});
	
	$('.ourClients').fcsCarousel();
	
	$('.tool-tip').tooltip();
	$('.pop-over').popover();
	$('.pop-over').on('click',function(e){
		e.preventDefault();
	});
	
	$( ".accordion" ).accordion({
		heightStyle: "content"
	}); 
	
	//Mobile Navigation
	$('.menu').mobileMenu({
	   defaultText: 'Navigate to...',
	   className: 'mnav',
	   subMenuDash: '&emsp;'
	});
	
	//Drop-Down Menu
	$(".menu li.parent, .menu li.parent li").hover(function () {
		$('a', this).addClass('current');
		$(this).children('ul').css({visibility: "visible", display: "none"}).slideDown(300);
	 }, function () {
		$('a', this).removeClass('current');
		$('ul', this).css({visibility: "hidden", display: "none"});
	});
	
	//Services Animation effect in home pages
	$('.animateIcon, .icon190, .icon100').hover(function(){
		$this = $(this);
		$this.parents('.singleService').addClass('hover').find('.title').addClass('orange');				
	},
	function(){
		$this = $(this);
		$this.parents('.singleService').removeClass('hover').find('.title').removeClass('orange');	
	});	
	
	//Icon Animation in services Page
	$('.animateIconServices').hover(function(){
		$this = $(this);
		$this.find('.serviceTitle').addClass('orange').end().parent().find('.singleService').addClass('hover');				
	},
	function(){
		$this = $(this);
		$this.find('.serviceTitle').removeClass('orange').end().parent().find('.singleService').removeClass('hover');
	});		
})();

//Google Search
document.getElementById('topSearchForm').onsubmit = function() {
	window.location = 'http://www.google.com/search?q=site:yoursitename.com ' + document.getElementById('txtSearch').value;
	return false;
}