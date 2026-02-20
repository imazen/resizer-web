---
title: "Configuration Reference"
---

This is a reference for all v5 Web.config settings. Only add settings you need to change — the defaults are sensible.

```xml
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <configSections>
    <section name="resizer"
             type="ImageResizer.ResizerSection"
             requirePermission="false"/>
  </configSections>

  <resizer>
    <!-- Pipeline settings (optional) -->
    <pipeline fakeExtensions=".ashx"
              defaultCommands="autorotate.default=true" />

    <!-- Drop querystring keys to prevent cache-busting params
         from creating duplicate cache entries -->
    <pipeline dropQuerystringKeys="cb,cachebuster" />

    <!-- Diagnostics access control -->
    <diagnostics enableFor="Localhost|AllHosts|None" />

    <!-- Client-side caching (Expires header).
         minutes="1440" = 24 hours. Default: 0 (no Expires header). -->
    <clientcache minutes="1440" />

    <!-- URL presets -->
    <presets onlyAllowPresets="false">
      <preset name="thumb" settings="width=100;height=100;mode=crop" />
      <preset name="medium" defaults="quality=85" settings="width=800" />
    </presets>

    <!-- 404 fallback images -->
    <image404 baseDir="~/Images/404Images/"
              myPreset="~/Images/404Images/missing.png" />

    <!-- HybridCache (replaces DiskCache from v4) -->
    <hybridCache
      cacheLocation="C:\imageresizercache\"
      cacheSizeMb="1000"
      writeQueueMemoryMb="100"
      evictionSweepSizeMb="1"
      shardCount="8" />

    <!-- Size limits (GDI pipeline only; Imageflow has its own defaults) -->
    <sizelimits imageWidth="3200" imageHeight="3200"
                totalWidth="3200" totalHeight="3200"
                totalBehavior="throwexception" />

    <!-- RemoteReader signing key (keep secret, keep consistent across web farm) -->
    <remotereader signingKey="put-a-long-secure-key-here" />

    <!-- Watermarks (v5.1+, image-only, no text watermarks) -->
    <watermarks defaultImageQuery="scache=true">
      <image name="logo"
             path="~/watermarks/logo.png"
             right="10px" bottom="10px" width="100px" />
      <group name="composite">
        <image path="~/watermarks/logo1.png"
               left="10px" top="10px" />
        <image path="~/watermarks/logo2.png"
               right="10px" bottom="10px" />
      </group>
    </watermarks>

    <!-- Licensing -->
    <licenses>
      <license>YOUR-LICENSE-KEY</license>
      <!-- Map staging domains to the licensed production domain -->
      <maphost from="staging.example.com" to="example.com" />
    </licenses>

    <!-- Plugins -->
    <plugins>
      <!-- Image processing backend (required for v5 features) -->
      <add name="Imageflow" />

      <!-- Disk caching -->
      <add name="HybridCache" />

      <!-- Storage providers (add as needed) -->
      <add name="AzureReader2"
           connectionString="DefaultEndpointsProtocol=https;AccountName=...;AccountKey=..."
           endpoint="https://account.blob.core.windows.net/" />

      <add name="S3Reader2"
           buckets="my-bucket"
           region="us-east-1" />

      <add name="RemoteReader" />
    </plugins>
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

## HybridCache settings

| Setting | Default | Description |
|---------|---------|-------------|
| `cacheLocation` | (required) | Absolute path to cache directory. Must be outside the web root. |
| `cacheSizeMb` | `1000` | Maximum total cache size in MB. |
| `writeQueueMemoryMb` | `100` | Memory budget for the write-ahead queue. |
| `evictionSweepSizeMb` | `1` | Amount of data to evict per cleanup sweep. |
| `shardCount` | `8` | Number of subdirectories for parallel I/O. |

## Licensing options

| Config | Behavior when unlicensed |
|--------|--------------------------|
| `licenseError="watermark"` | Draws a red dot on processed images (default) |
| `licenseError="exception"` | Returns HTTP 402 or 422 |

## Removed from v4

These v4 configuration elements are no longer used:

- `<diskCache>` — replaced by `<hybridCache>`
- `<cleanupStrategy>` — HybridCache manages its own eviction
- `<nlog>` — the Logging plugin is deprecated
- `<cloudfront>` — the CloudFront plugin is deprecated
