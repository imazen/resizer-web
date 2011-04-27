hljs.tabReplace = '  '; 
hljs.initHighlightingOnLoad();

$(function(){
	$(".banners").jshowoff({speed:10000});
	/*$('pre code').not('code[class]').each(function(i, e) {$(e).addClass('csharp c-sharp'); hljs.highlightBlock(e, '  ')});*/
});

$('a[href$=".zip"]').click(function(){
	_gaq.push(['_trackPageview', $(this).attr('href') ]);
});