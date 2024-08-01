---
:append: edition_info
:tags: plugin
:bundle: free
:edition: free
:tagline: Allows logging through NLog
:aliases: []
:edit_info: support/v3/plugins/logging/readme.md
:flags:
- "-sitemap"
---

# Logging plugin (v3.1+)

The Logging plugin allows the Image Resizer to perform logging (to disk, SQL, e-mail, whatever you configure).

It is a wrapper for NLog, and as such, requires NLog.dll

## Installation

Either run `Install-Package ImageResizer.Plugins.Logging` in the NuGet package manager, or:

1. Add ImageResizer.Plugins.Logging.dll to your project. NLog.dll is also needed, but doesn't have to be referenced directly - it should be automatically copied if you are using Visual Studio. If not, copy it to the /bin folder as well
2. Add `<add name="Logging" />` inside `<plugins></plugins>` in Web.config.


NuGet or not, you'll need to manually add a configuration section for NLog and configure logging rules & targets:

  <configSections>
    <section name="resizer" type="ImageResizer.ResizerSection"/>
    <section name="nlog" type="NLog.Config.ConfigSectionHandler, NLog"/>
  </configSections>
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


## Notes

Currently, detailed logging has only been implemented for the DiskCache plugin. Set `logging=true` on the `<diskcache />` element to enable it.