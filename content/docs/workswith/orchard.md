# Orchard Compatibility

# Multi-tenanting

While the ImageResizer architecture is designed to make multi-tenanting support easy to implement, there don't seem to be many people that are gurus on Orchard's multi-tenanting architecture. If you are one, why not help us out a little? 

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