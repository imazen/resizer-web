uservoice: true

# How to use the Image Resizer without ASP.NET

It's just as easy. If you want to use the COM interface, [read this page](/docs/howto/use-from-com). If you're using the URL API (a better choice), continue with this article.

You do have to be running Windows and IIS, though. If you are not, remember you can set up a separate port or subdomain dedicated to images, separate from your application, using IIS. Or, use a separate Windows server to handle imagery.

1. Create a folder in the site named 'bin'. [Download](/download/) ImageResizer.dll and paste it into the 'bin' folder, along with any plugins you wish to use.
2. Create a new file named "Web.config" in the root of the site. Paste the following into it.
	
		<?xml version="1.0" encoding="utf-8" ?>
		<configuration>
		  <configSections>
		    <section name="resizer" type="ImageResizer.ResizerSection,ImageResizer" />
		  </configSections>
		  <resizer>
		    <!-- Unless you (a) use Integrated mode, or (b) map all reqeusts to ASP.NET, 
		         you'll need to add .ashx to your image URLs: image.jpg.ashx?width=200&height=20 
		         Optional - this is the default setting -->
		    <pipeline fakeExtensions=".ashx" />
		    <plugins>
		      <!-- <add name="DiskCache" /> -->
		      <!-- <add name="PrettyGifs" /> -->
		    </plugins>	
		  </resizer>
		  <system.web>
		    <httpModules>
		      <!-- This is for IIS5, IIS6, and IIS7 Classic, and Cassini/VS Web Server-->
		      <add name="ImageResizingModule" type="ImageResizer.InterceptModule"/>
		    </httpModules>
		  </system.web>
		  <system.webServer>
		    <validation validateIntegratedModeConfiguration="false"/>
		    <modules>
		      <!-- This is for IIS7+ Integrated mode -->
		      <add name="ImageResizingModule" type="ImageResizer.InterceptModule"/>
		    </modules>
		  </system.webServer>
		</configuration>
	

3. You're done! Visit /resizer.debug.ashx to verify everything is working. If you need help, [just ask](/support)!


