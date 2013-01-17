# Installing a plugin.

## Installing one of the included Basic plugins

1. In the [&lt;plugins /> section](/docs/configuration) of Web.config, insert &lt;add name="PluginName" />

## Installing another bundle

You can find the plugin DLL files in the /dlls/release folder of your download. Trial versions are located in /dlls/trial/

1. In Visual Studio, right click on your project and choose "Add reference". Browse to the plugin DLL and click "OK". 
2. In the [&lt;plugins> section](/docs/configuration) of Web.config, insert &lt;add name="PluginName" />
3. Look at the plugin documentation to see what configuration options (if any) are available.
