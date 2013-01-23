
# Maturity chart

Last updated Jan 22, 2013 regarding V3.3.1

This chart represents the author's honest opinion on the maturity of the various plugins. 

Meaning of the terms *stable*, *beta*, and *alpha* in the context of this project.

* *stable* - Extremely well tested, reliable, and API changes would be unlikely. Very high confidence rating.
* *beta* - Lots of testing has occurred, and the plugin has had a significant user base for several months.
* *alpha* - Either (a) the plugin has a very small user base (AzureReader, BatchZipper, PsdComposer), or (b) the plugin is fewer than 2 months old, and therefore hasn't endured enough real-world usage for long enough to be classified as *beta* or *stable*.

You shouldn't worry about using alpha plugins on production servers; even alpha-rated plugins have undergone extensive security assessment and memory usage profiling. It's very unlikely an alpha plugin will cause external issues - at worst, it may simply not function properly in  certain usage scenarios. Also, remember... Free Support! Alpha plugins get the same level of support that the rest do.


## Core & Free plugins

* Core framework - *stable* (likely to have API refinements, but otherwise very stable)
* DefaultEncoder - *stable*
* NoCache - *stable*
* Diagnostics - *stable*
* ClientCache - *stable*
* SizeLimiting - *stable*
* DropShadow - *stable* 
* Gradient - *stable*
* FolderResizeSyntax - *stable*
* Image404 -  *beta*
* VirtualFolder - *stable*
* ImageHandlerSyntax - *stable*
* MvcRoutingShim - *stable*
* AutoRotate - *stable*
* Presets - *stable* 
* SpeedOrQuality - *beta*
* Logging - *alpha*
* DefaultSettings - *stable*
* IEPngFix - *alpha*
* PdfRenderer - *alpha* 

## Performance Bundle

* PrettyGifs - *stable*
* AnimatedGifs - *stable*
* DiskCache - *stable*

## Designer Bundle

* PsdReader - *beta*
* Watermark - *beta*
* AdvancedFilters - *beta*
* SimpleFilters - *stable*
* SeamCarving - *beta* 
* WhitespaceTrimmer - *beta*
* FreeImageDecoder - *beta*
* FreeImageEncoder - *beta*
* FreeImageResizer - *beta*
* FreeImageBuilder - *beta*
* WicDecoder - *beta*
* WicEncoder - *beta*
* WicBuilder - *beta*

## Cloud Bundle


* S3Reader - *stable*
* SQLReader - *stable* 
* CloudFront - *stable*
* RemoteReader - *stable*
* AzureReader - *beta*
* MongoReader - *alpha*

## Intense Bundle

* BatchZipper - *alpha*
* PsdComposer - *beta*

<script type="text/javascript">
//<!--

if (loadq === undefined) var loadq = [];
loadq.push(function(){
	$("em:contains('alpha')").addClass('alpha');
	$("em:contains('beta')").addClass('beta');
	$("em:contains('stable')").addClass('stable');
});
//-->
</script>

<style type="text/css">
em.alpha{color:red;}
em.stable{color:green;}
em.beta{color:#333;}
</style>