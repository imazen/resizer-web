$(function(){
	$(".banners").jshowoff({speed:10000});
});
hljs.tabReplace = '  '; 
hljs.initHighlightingOnLoad();
$('a[href$=".zip"]').click(function(){
	_gaq.push(['_trackPageview', $(this).attr('href') ]);
});