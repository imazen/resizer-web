
# Configuration Reference

`Please note - this page is nearly a year out of data, and very incomplete. It will be updated soon`

This is a full reference showing how to use each setting. You should *not* copy this into your site. Only change the settings you need to, and only specify the settings you change.


	<?xml version="1.0" encoding="utf-8" ?>
	<configuration>
		<configSections>
			<section name="resizer" type="ImageResizer.ResizerSection,ImageResizer"  requirePermission="false"  />
		</configSections>

		<resizer>
			<!-- Unless you (a) use Integrated mode, or (b) map all reqeusts to ASP.NET, 
					 you'll need to add .ashx to your image URLs: image.jpg.ashx?width=200&height=20 
					 vppUsage defaults to 'Fallback', which means VirtualPathProviders are used if the physical file doesn't exist.
					 Optional - these are the default settings -->
			<pipeline fakeExtensions=".ashx" vppUsage="Always|Fallback|None"/>
	
			<!-- minutes specifies how far in the future to set the Expires: header. The Expires header 
					 tells the browser to not even *check* for a newer version until the Expires header expires. 
					 Defaults to 0 - header not sent. 1440 is 24 hours, a good value. 
					 See http://imageresizing.net/plugins/clientcache for details.-->
			<clientcache minutes="0" />
	
			<!-- Overrides the 'custom errors' setting. Enables the /resizer.debug page for the specified clients. 
					 Defaults to the same behavior specified in customErrors, so it won't expose data. 
					 See http://imageresizing.net/plugins/diagnostics for details. -->
			<diagnostics enableFor="Localhost|AllHosts|None" />
	
			<!-- The image404 plugin (when installed) lets you specify a 404 fallback in the querystring
					 If the image doesn't exists. You can also reference 'presets'. 
					 Ex. image.jpg?404=myPreset and image.jpg?404=404-whale.png would result in the same behavior 
					 See http://imageresizing.net/plugins/image404 for details. -->
			<image404 baseDir="~/Images/404Images/" myPreset="~/Images/404Images/404-whale.png" />
			
			<!-- see http://imageresizing.net/plugins/sizelimiting for detailed docs -->
			<sizelimits imageWidth="0" imageHeight="0" totalWidth="3200" totalHeight="3200" totalBehavior="throwexception" />
			
			<!-- See http://imageresizing.net/plugins/diskcache for details. Avoid changing these settings -->
			<diskCache dir="~/imagecache" autoClean="false" hashModifiedDate="true" enabled="true" subfolders="32" cacheAccessTimeout="15000" />

			<cleanupStrategy startupDelay="00:05" minDelay="00:00:20" maxDelay="00:05" optimalWorkSegmentLength="00:00:04" targetItemsPerFolder="400" maximumItemsPerFolder="1000" 
			  avoidRemovalIfCreatedWithin="24:00" avoidRemovalIfUsedWithin="4.00:00" prohibitRemovalIfUsedWithin="00:05" prohibitRemovalIfCreatedWithin="00:10" />
			
			<plugins>
				<!-- These are installed by default. We're only removing and re-adding them to show an example. It's pointless ->
				<remove name="DefaultEncoder" />
				<remove name="NoCache" />
				<remove name="ClientCache" />
				<remove name="Diagnostics />
				<add name="DefaultEncoder" />
				<add name="NoCache" />
				<add name="ClientCache" />
				<add name="Diagnostics />
				
				
				<!-- This plugin is installed by default on ASP.NET sites (not for WinForms, Console, or WPF apps) -->
				<add name="SizeLimiting" />
				
				<!-- The remaing plugins are *not* installed by default, but are included in ImageResizer.Dll -->
				
				<!-- http://imageresizing/plugins/gradient -->
				<add name="Gradient" />
				
				<!-- http://imageresizing.net/plugins/image404 -->
				<add name="Image404" />
				
				
				<!-- Works like an IIS virtual folder, but without IIS.  -->
				<add name="VirtualFolder" virtualPath="~/" physicalPath="..//Images" />
				<add name="VirtualFolder" virtualPath="~/watermarks" physicalPath="..//Watermarks" />
				
				
				<!-- The remaining plugins are not included in ImageResizer.dll - they have their own DLLs ->
				
				<!-- Performance Edition starts here -->
				
				<!-- http://imageresizing.net/plugins/diskcache -->
				<add name="DiskCache" />
				
				<add name="PrettyGifs" />
				
				<add name="AnimatedGifs" />

				<!-- Adds the /resize(w,h,f)/ folder syntax -->
				<add name="FolderResizeSyntax" />
				
				<!-- Designer Edition starts here -->
				
				<add name="AdvancedFilters" />
				<add name="PsdReader" />
				<add name="SimpleFilters" />
				<!-- Actually, you add Watermark from C# code - 
				     configuration is rather comprehensive, and 
				     it doesn't have an xml representation yet -->
				<add name="Watermark" />
				
				<!-- Cloud Edition starts here -->
				<add name="CloudFront" />
				<!-- S3Reader and SqlReader are best configured and added from C# code during App_Start -->
				<add name="S3Reader" />
				<add name="SqlReader" />
				
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