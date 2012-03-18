Tags: plugin
Bundle: free

# Custom Overlay plugin

New in V3.1.6

This is an example plugin. It is useful as a starting point, but is not subject to the same standards of maintenance and backwards-compatibility that normal plugins are. It does not have a NuGet package or precompiled binaries.

This plugin is for drawing image overlays using pre-determined x1,y1,x2,y2,x3,y3,x4,y4 coordinates that are relative to the base file's width and height. It supports any parallelogram, and can use any virtual path for loading the overlay image. 

Implement the IOverlayProvider interface to provide your own querystring parsing and/or database code. Add a constructor that accepts a NameValueCollection as an argument, so it can be dynamically created by the plugin.

The plugin includes two implementations:

1. QuerystringOverlayProvider - Understands `&amp;customoverlay.coords=x1,y2,x2,y2,x3,y3,x4,y4&amp;customoverlay.align=topright&amp;customoverlay.image=alphanumeric.png` Points must be in clockwise order, top-left is x1,y1. 
2. A CachedOverlayProvider implementation that is database-specific and uses the `&amp;designid=504&amp;mastid=8540&amp;colorid=9633` syntax.

See Samples\CustomOverlaySample for an example

## Generic Installation

1. Add a project reference to Samples/CustomOverlayPlugin. You may want to copy it to your directory.
2. In the plugins section, add the following
		<add name="CustomOverlay" 
			provider="MyNamespace.MyOverlayProviderClass, MyAssembly" 
			arg1="value1" arg2="value2.." />`

## Installation using QuerystringOverlayProvider

1. Add a project reference to Samples/CustomOverlayPlugin. You may want to copy it to your directory.
2. In the plugins section, add the following
		<add name="CustomOverlay" 
			provider="ImageResizer.Plugins.CustomOverlay.QuerystringOverlayProvider, ImageResizer.Plugins.CustomOverlay"
			overlayFolder="~/images/overlays/" />


## Installation using CachedOverlayProvider

1. Add a project reference to Samples/CustomOverlayPlugin. You may want to copy it to your directory.
2. In the plugins section, add the following
		<add name="CustomOverlay" 
			provider="ImageResizer.Plugins.CustomOverlay.CachedOverlayProvider, ImageResizer.Plugins.CustomOverlay" 
			connectionStringName="database" sqlDependencyName="dpdb" overlayBasePath="~/images/foldertooverlays" />`

3. Ensure you have a connection string by the name of 'database' in Web.config.
4. Ensure overlayBasePath points to the folder containing the overlay images.
5. Configure SqlCacheDependency (or remove the sqlDependencyName attribute) - but you won't get invalidation when data changes - images won't update until the app pool restarts.


## Configuring SqlCacheDependency 

(Only required for CachedOverlayProvider)

A little bit of work is required to get ASP.NET and SQL talking about changes.

First, you'll [need to run aspnet_regsql.exe on the database and on each of the tables involved](http://weblogs.asp.net/andrewrea/archive/2008/07/13/sqlcachedependency-i-think-it-is-absolutely-brilliant.aspx) ("LogoDesignMap", "LogoDesign", "LogoUsage", "Organization", "LogoImage2", "Color").


Second, you'll need to set up Web.config. Make sure you have a connection string already, then add the <sqlCacheDependency> element as shown in the below example:

Pay particular attention that the 'name' value below ("dpdb") matches the sqlDependencyName value from above, and that the connectionStringName matches the connectionStringName from above.


	<connectionStrings>
		<clear/>
		<add name="database" 
				connectionString="Data Source=REA_ANDREW-PC\SQLEXPRESSADV;Initial Catalog=Forum; 
				Integrated Security=true;" providerName="System.Data.SqlClient"/>
	</connectionStrings>
	<system.web>
		<caching>
		    <sqlCacheDependency pollTime="1000" enabled="true">
				<databases>
					<add connectionStringName="database" name="dpdb"/>
				</databases>
		    </sqlCacheDependency>
		</caching>
	</system.web>