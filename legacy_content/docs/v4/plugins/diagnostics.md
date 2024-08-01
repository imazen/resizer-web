---
:append: edition_info
:tags: plugin
:edition: free
:bundle: free
:tagline: "(default) - Whenever you have an issue, go to localhost/resizer.debug and
  you'll probably be told what is wrong."
:aliases: "/plugins/diagnostics /plugins/diagnostic"
:edit_info: develop/core/plugins/basic/diagnostics_readme.md
---

# Diagnostics plugin

The `/resizer.debug` page is provided by this plugin (which is installed by default)

If you're not using IIS Integrated mode, you will need to access it via /resizer.debug.ashx

## Diagnostics page not working?

By default, the Diagnostics plugin uses the same setting as [customErrors](http://msdn.microsoft.com/en-us/library/h0hfz6fc%28v=vs.100%29.aspx) (which defaults to Localhost). Thus, if you can see ASP.NET error messages, you will also be able to get the diagnostics page. This ensures that the diagnostics page never exposes data to a host that doesn't already have access to detailed error messages. 

To override, add one of the following to the &lt;resizer&gt; section.

  <diagnostics enableFor="AllHosts" />
  <diagnostics enableFor="Localhost" />
  <diagnostics enableFor="None" />
  


I think they are pretty obvious.