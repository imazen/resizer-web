Append: /docs/install/generic

# Orchard and ImageResizer

Standard installation steps are sufficent for the Essential Edition, but an additional Web.config file must be changed for DiskCache to work properly.

## Multi-tenanting

While the [ImageResizer architecture is designed to make multi-tenanting support easy to implement](/docs/how/multi-tenanting), no Orchard guru has yet stepped forward to implement the `glue`. 


## Building a gallery module for Orchard using ImageResizer

Dave Gardner [wrote a fantastic 7-part article on how to make a gallery module for Orchard using the ImageResizer](http://bigsitesdoneright.com/big-blog/orchard-cascade-gallery-tutorial-series).

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