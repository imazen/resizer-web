---
title: "Install ImageResizer 5"
---

## Quick start (NuGet)

Open the NuGet Package Manager Console in Visual Studio (**Tools > NuGet Package Manager > Package Manager Console**):

```powershell
PM> Install-Package ImageResizer.WebConfig
PM> Install-Package ImageResizer.Plugins.Imageflow -pre
PM> Install-Package Imageflow.NativeRuntime.win-x86 -pre
PM> Install-Package Imageflow.NativeRuntime.win-x86_64 -pre
PM> Install-Package ImageResizer.Plugins.HybridCache
```

`ImageResizer.WebConfig` handles the Web.config HttpModule registration automatically.

The native runtime packages contain `imageflow.dll` — the Rust image processing library. Install both x86 and x86_64 unless you know your deploy target.

## Configure Web.config

After NuGet installation, add the Imageflow and HybridCache plugins to your `<resizer>` section:

```xml
<configuration>
  <configSections>
    <section name="resizer"
             type="ImageResizer.ResizerSection"
             requirePermission="false"/>
  </configSections>

  <resizer>
    <plugins>
      <add name="Imageflow" />
      <add name="HybridCache" />
    </plugins>
    <hybridCache cacheLocation="C:\imageresizercache\"
                 cacheSizeMb="1000" />
  </resizer>

  <system.web>
    <httpModules>
      <!-- IIS 7/8 Classic Mode and Cassini -->
      <add name="ImageResizingModule"
           type="ImageResizer.InterceptModule"/>
    </httpModules>
  </system.web>

  <system.webServer>
    <validation validateIntegratedModeConfiguration="false"/>
    <modules>
      <!-- IIS 7+ Integrated mode -->
      <add name="ImageResizingModule"
           type="ImageResizer.InterceptModule"/>
    </modules>
  </system.webServer>
</configuration>
```

### HybridCache location

The `cacheLocation` **must be outside your web root.** Unlike v4's DiskCache (which used `~/imagecache/`), HybridCache stores processed images in an arbitrary directory. This prevents the cache from being directly browsable.

If you're migrating from v4 DiskCache, **delete the old `~/imagecache/` folder** — it would otherwise be publicly accessible.

## Verify

Start your site and browse to `/resizer.debug` (or `/resizer.debug.ashx`). This diagnostics page shows:

- Which plugins are installed and active
- Whether Imageflow native libraries loaded successfully
- License status
- Any configuration warnings

If Imageflow fails to load, check that the native runtime NuGet packages installed correctly and that `imageflow.dll` is present in your bin directory.

## Available NuGet packages

| Package | Purpose |
|---------|---------|
| `ImageResizer.WebConfig` | Core + Web.config registration |
| `ImageResizer.Plugins.Imageflow` | Imageflow processing backend |
| `Imageflow.NativeRuntime.win-x86` | Native library (32-bit) |
| `Imageflow.NativeRuntime.win-x86_64` | Native library (64-bit) |
| `ImageResizer.Plugins.HybridCache` | Disk caching with size limits |
| `ImageResizer.Plugins.AzureReader2` | Azure Blob Storage source |
| `ImageResizer.Plugins.S3Reader2` | Amazon S3 source |
| `ImageResizer.Plugins.RemoteReader` | HTTP/HTTPS image proxy |

All `ImageResizer.*` packages must share the same version number.
