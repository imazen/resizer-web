---
title: "System Requirements"
---

## .NET Framework

- **.NET Framework 4.8** required (4.7.2 minimum for the core assembly)
- Visual Studio 2019 or later

## Operating systems

Both 32-bit and 64-bit Windows:

- Windows 10 / 11
- Windows Server 2016, 2019, 2022

Older Windows versions (7, 8.1, Server 2012 R2) may work but are not tested.

## Web servers

- IIS 7.5+ (Integrated or Classic mode)
- IIS Express

## Native dependencies

ImageResizer 5 requires the Imageflow native library (`imageflow.dll`). This is delivered via NuGet:

- `Imageflow.NativeRuntime.win-x86` (32-bit)
- `Imageflow.NativeRuntime.win-x86_64` (64-bit)

Install both unless you know your deployment architecture. The correct DLL is loaded at runtime.

## Hosting

Full trust is required. Shared hosting plans that restrict trust levels won't work.

The HybridCache plugin requires write access to a directory outside the web root (configured via `cacheLocation`). Make sure your application pool identity has write permissions to that path.

## For .NET 6+ projects

Don't use ImageResizer 5. Use [Imageflow Server](https://github.com/imazen/imageflow-dotnet-server) instead — it's designed for modern .NET and runs cross-platform (Windows, Linux, macOS).
