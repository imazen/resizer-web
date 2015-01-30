Tags: cms


# Orchard and ImageResizer

Standard installation steps are sufficient for the Essential Edition, but an additional Web.config file must be changed for DiskCache to work properly.

## Orchard Contrib.Cache duplicates content once for each handler for the HttpApplication.PreSendRequestHeaders event

* [See bug report on CodePlex](http://stackoverflow.com/questions/14777337/imageresizer-net-with-cache-plugin-causing-duplicate-output-cache)

This means that for now, you can't use ImageResizer and the Contrib.Cache Orchard plugin together.

## Multi-tenanting

While the [ImageResizer architecture is designed to make multi-tenanting support easy to implement](/docs/extend/multi-tenanting), no Orchard guru has yet stepped forward to implement the `glue`. 


## Building a gallery module for Orchard using ImageResizer

Dave Gardner [wrote a fantastic 7-part article on how to make a gallery module for Orchard using the ImageResizer](http://bigsitesdoneright.com/big-blog/orchard-cascade-gallery-tutorial-series).

* [Bertrand Le Roy (Orchard author): State of .NET Image Resizing: how does imageresizer do?](http://weblogs.asp.net/bleroy/archive/2011/10/22/state-of-net-image-resizing-how-does-imageresizer-do.aspx) * Note the performance chart is bogus due to a mistake in the Bertrand's benchmark code. [The corrected chart](http://downloads.imageresizing.net/Oct29-2011-comparison.png) displays actual apples-to-apples data, instead of comparing low-quality and high-quality image resizing as the original benchmark does.


## Disk Cache Support

Strangely, Orchard disables the serving of static files at the site root level by removing all httpHandlers. For Disk Caching to work, you will need to customize the imagecache/Web.config file. 

Restoring the StaticFileHandler mappings should re-enabled efficient disk caching. 

	<?xml version="1.0"?>
	<configuration>
		<system.web>
			<authorization>
				<deny users="*" />
			</authorization>
			<httpHandlers>
				<!-- iis6 - for any request in this location, return via managed static file handler -->
				<add path="*" verb="*" type="System.Web.StaticFileHandler" />
			</httpHandlers>
		<system.webServer>
			<validation validateIntegratedModeConfiguration="false"/>
			<handlers accessPolicy="Script,Read">
				<!--
				iis7 - for any request to a file exists on disk, return it via native http module.
				accessPolicy 'Script' is to allow for a managed 404 page.
				-->
				<add name="imagecache" path="*" verb="*" modules="StaticFileModule" preCondition="integratedMode" resourceType="File" requireAccess="Read" />
			</handlers>
		</system.webServer>
	</configuration>
