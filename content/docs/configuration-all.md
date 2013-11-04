
# Configuration Reference

`Please note - this page is nearly a year out of data, and very incomplete. It will be updated soon`

This is a full reference showing how to use each setting. You should *not* copy this into your site. Only change the settings you need to, and only specify the settings you change.


	<?xml version="1.0" encoding="utf-8" ?>
	<configuration>
		<configSections>
			<section name="resizer" type="ImageResizer.ResizerSection,ImageResizer"  requirePermission="false"  />
		  <section name="nlog" type="NLog.Config.ConfigSectionHandler, NLog"/>
		</configSections>
		<!-- configuration section for NLog and configure logging rules & targets -->
		<!-- http://imageresizing.net/plugins/logging -->
		<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd"
		    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
		  
		  <targets  async="true" >
		    <target name="resizer" xsi:type="File" fileName="${basedir}/Logs/Resizer.txt" />
		    <target name="diskcache" xsi:type="File" fileName="${basedir}/Logs/Diskcache.txt" layout="${processid} ${pad:padCharacter= :padding=3:inner=${threadid}} ${time} ${message}"  />
		  </targets>

		  <rules>
		    <logger name="ImageResizer.Plugins.DiskCache" minlevel="Trace" writeTo="diskcache" final="true"  />
		    <logger name="*" minlevel="Debug" writeTo="resizer" />
		  </rules>
		</nlog>
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
			<clientcache minutes="0|1440" />
			
			<!-- When onlyAllowPresets="true", all other querystring pairs will be stripped from the URL. 
			     Naturally, this will break the RemoteReader plugin if you're using the signed URLs. 
			     onlyAllowPresets does not apply to the managed API, only to the URL API 
			     See http://imageresizing.net/plugins/presets for details.-->
			<presets onlyAllowPresets="true|false">
				<preset name="thumb-defs" defaults="width=100;height=100" />
				<preset name="thumb" settings="width=100;height=100" />
				<preset name="thumb-width" defaults="height=100" settings="width=100" /><!-- The height can be overriden, but not the width -->
			</presets>
	
			<!-- Overrides the 'custom errors' setting. Enables the /resizer.debug page for the specified clients. 
					 Defaults to the same behavior specified in customErrors, so it won't expose data. 
					 See http://imageresizing.net/plugins/diagnostics for details. -->
			<diagnostics enableFor="Localhost|AllHosts|None" />
	
			<!-- The image404 plugin (when installed) lets you specify a 404 fallback in the querystring
					 If the image doesn't exists. You can also reference 'presets'. 
					 Ex. image.jpg?404=myPreset and image.jpg?404=404-whale.png would result in the same behavior 
					 See http://imageresizing.net/plugins/image404 for details. -->
			<image404 baseDir="~/Images/404Images/" myPreset="~/Images/404Images/404-whale.png" />
			

			<!-- The DefaultSettings plugin allows you to specify the default settings to use when certain 
			     settings are omitted. Currently supports ScaleMode defaults. 
			     See http://imageresizing.net/plugins/defaultsettings for details. -->
			<defaultsettings explicitSizeScaleMode="DownscaleOnly" maxSizeScaleMode="DownscaleOnly" />
			
			<!-- see http://imageresizing.net/plugins/sizelimiting for detailed docs -->
			<sizelimits imageWidth="0" imageHeight="0" totalWidth="3200" totalHeight="3200" totalBehavior="throwexception" />
			
			<!-- See http://imageresizing.net/plugins/diskcache for details. Avoid changing these settings -->
			<diskCache dir="~/imagecache" autoClean="false" hashModifiedDate="true" enabled="true" subfolders="32" cacheAccessTimeout="15000" />

			<cleanupStrategy startupDelay="00:05" minDelay="00:00:20" maxDelay="00:05" optimalWorkSegmentLength="00:00:04" targetItemsPerFolder="400" maximumItemsPerFolder="1000" 
			  avoidRemovalIfCreatedWithin="24:00" avoidRemovalIfUsedWithin="4.00:00" prohibitRemovalIfUsedWithin="00:05" prohibitRemovalIfCreatedWithin="00:10" />
			
			<plugins>
				<!-- These are installed by default. We're only removing and re-adding them to show an example. It's pointless -->
				<remove name="DefaultEncoder" />
				<remove name="NoCache" />
				<remove name="ClientCache" />
				<remove name="Diagnostics />
				<add name="DefaultEncoder" />
				<add name="NoCache" />
				<add name="ClientCache" />
				<add name="Diagnostics />

				
				<!-- Unless otherwise noted, the remaining plugins are not included in ImageResizer.dll - they have their own DLLs -->
				

				<!----------------------------------->
				<!-- Essential Edition starts here -->
				<!----------------------------------->

				<!-- Adds the /resize(w,h,f)/ folder syntax -->
				<!-- You must remove the <add name="FolderResizeSyntax" /> if present -->
				<!-- http://imageresizing.net/plugins/folderresizesyntax -->
				<add name="FolderResizeSyntax" />

				<!-- Adds the MvcRoutingShim -->
				<!-- http://imageresizing.net/plugins/mvcroutingshim -->
				<add name="MvcRoutingShim" />

				<!-- Adds the PdfRender -->
				<!-- If you set downloadNativeDependencies="false" or you're running < V3.2, place gsdll32.dll and gsdll64.dll in the /bin directory -->
				<!-- http://imageresizing.net/plugins/pdfrenderer -->
				<add name="PdfRenderer" downloadNativeDependencies="true" />

				<!-- Add IEPngFix -->
				<!-- http://imageresizing.net/plugins/iepngfix -->
				<!-- If redirect="true" (the default), the requests from IE will be HTTP redirected to new URLs. If false, the GIF will be silently served instead of the PNG, without any redirection. -->
				<!-- When catchAll=false, the behavior is opt-in. You must add &iefix=true to enable the browser detection and redirection behavior for the URL. -->
				<!-- When catchAll=true, the behavior is opt-out. You must add &iefix=false to disable the browser detection and redirection behavior for the URL. -->
				<add name="IEPngFix" redirect="true|false" catchAll="true|false" />
				
				<!-- Add SideLimiting plugin -->
				<!-- This plugin is installed by default on ASP.NET sites (not for WinForms, Console, or WPF apps) -->
				<!-- See Remove SizeLimiting Below -->
				<!-- http://imageresizing.net/plugins/sizelimiting -->
				<add name="SizeLimiting" />
				
				<!-- Remove SizeLimiting -->
				<!-- http://imageresizing.net/plugins/sizelimiting -->
				<!-- In rare cases, it may make sense to completely remove the plugin. -->
	      <!-- <remove name="SizeLimiting" /> -->

				<!-- Add SpeedOrQuality (v3.1+) -->
				<!-- http://imageresizing.net/plugins/speedorquality -->
	      <add name="SpeedOrQuality" />

	      <!-- Add Drop Shadow -->
	      <!-- http://imageresizing.net/plugins/dropshadow -->
	      <add name="DropShadow" />

				<!-- Add Presets plugin (v3.1+) -->
				<!-- http://imageresizing.net/plugins/presets -->
	      <add name="Presets" />

	      <!-- Add Logging plugin (v3.1+) -->
	      <!-- Add ImageResizer.Plugins.Logging.dll to your project. NLog.dll is also needed, but doesn't have to be referenced directly - it should be automatically copied if you are using Visual Studio. If not, copy it to the /bin folder as well -->
	      <!-- http://imageresizing.net/plugins/logging -->
	      <add name="Logging" />

				<!-- Add ImageHandlerSyntax plugin -->
				<!-- Adds support for the syntaxes used by 4 image resizing handlers. This plugin allows painless, gradual migration from them by supporting their URL syntax. -->
				<!-- http://imageresizing.net/plugins/imagehandlersyntax -->
	      <add name="ImageHandlerSyntax" />

				<!-- Add Image404 plugin -->
				<!-- This plugin is *not* installed by default, but is included in ImageResizer.Dll -->
				<!-- http://imageresizing.net/plugins/image404 -->
				<add name="Image404" />

				<!-- Custom Overlay plugin -->
				<!-- This is an example plugin. It is useful as a starting point, but is not subject to the same standards of maintenance and backwards-compatibility that normal plugins are. -->
				<!-- http://imageresizing.net/plugins/customoverlay -->
				<add name="CustomOverlay" provider="MyNamespace.MyOverlayProviderClass, MyAssembly" arg1="value1" arg2="value2.." ignoreMissingFiles="false" />

				<!-- Install Gradient plugin -->
				<!-- Generates gradients on the fly. Very useful for rapid prototyping and design - but safe for production use! -->
				<!-- This plugin is *not* installed by default, but is included in ImageResizer.Dll -->
				<!-- http://imageresizing/plugins/gradient -->
				<add name="Gradient" />

				<!-- DefaultSettings plugin (V3.1+) -->
				<!-- Allows you to specify the default settings to use when certain settings are omitted. Currently supports ScaleMode defaults.  -->
				<!-- http://imageresizing.net/plugins/defaultsettings -->
				<add name="DefaultSettings" />

				<!-- Works like an IIS virtual folder, but without IIS.  -->
				<!-- This plugins is *not* installed by default, but is included in ImageResizer.Dll -->
				<!-- http://imageresizing.net/plugins/virtualfolder -->
				<add name="VirtualFolder" virtualPath="~/" physicalPath="..//Images" />
				<add name="VirtualFolder" virtualPath="~/watermarks" physicalPath="..//Watermarks" />

				<!-- Add AutoRotate plugin (v3.1+) -->
				<!-- Automatically rotates images based on the EXIF Orientation flag embedded by the camera. -->
				<!-- http://imageresizing.net/plugins/autorotate -->
				<add name="AutoRotate" />


				<!------------------------------------->
				<!-- Performance Edition starts here -->
				<!------------------------------------->
				
				<!-- http://imageresizing.net/plugins/diskcache -->
				<add name="DiskCache" />

				<add name="PrettyGifs" />
				
				<add name="AnimatedGifs" />

				
				<!---------------------------------->
				<!-- Designer Edition starts here -->
				<!---------------------------------->
				
				<add name="AdvancedFilters" />
				<add name="PsdReader" />
				<add name="SimpleFilters" />
				<!-- Actually, you add Watermark from C# code - 
				     configuration is rather comprehensive, and 
				     it doesn't have an xml representation yet -->
				<add name="Watermark" />


				<!------------------------------->
				<!-- Cloud Edition starts here -->
				<!------------------------------->

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