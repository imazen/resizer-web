Aliases: /docs/howto/avoid-network-limit

# Network BIOS limit reached

Users of IIS and ASP.NET often receive the following error message when running a website from a network share or NAS device.

  The network BIOS command limit has been reached
  Failed to start monitoring changes


There are two causes; one from IIS, and one from ASP.NET. Both problems are triggered by a large number of folders in the site, and the protocol inefficiency of over-the-network storage.

The easy solution is - don't host your content on a SAN. Go cloud; put the content on S3, your server on EC2, and use CloudFront to make that system *scale*. If that's not an option, keep reading.

If both your storage server and ASP.NET server are running Windows Server 2008 or higher, [it's possible this *may* not bite you](http://www.iis.net/learn/troubleshoot/performance-issues/troubleshooting-smb-netbios-fcn-limit-issues-with-remote-content). Still, you'll probably see improved performance by stopping IIS & ASP.NET's per-folder file watcher.

## Part 1: Stop IIS from continually checking every folder for a web.config file

1. Go to IIS manager. 
2. Click the server name in the left panel (not the site name)
3. Scroll down and open Configuration Manager. 
4. Choose system.applicationHost/sites in the Section: field.
5. Click (collection) to bring up the Collection Editor, select the web site you wish to modify
6. In the bottom panel, expand the virtualDirectoryDefaults item. 
7. Change allowSubDirConfig to False instead of True
8. Click Apply in the right-hand panel to save your changes.

## Part 2: Stop ASP.NET from spinning up an individual watcher for every single folder on the website.

There are two solutions (other than not using a SAN)

2. Disable FCN (File change notifications) completely for ASP.NET. (Has side effects - no restart on web.config change, output cache gets dirty)
3. Raise the command limit (has a ceiling that you will hit if you have over 40,000 folders in sites on your server). To reiterate, this is a server-wide limit, not a site-specific limit. Each watcher also consumes I/O and CPU resources, so simply raising the limit will have an impact.

## Disabling FCN (.NET 4.5+)

Starting with the Microsoft .NET Framework 4.5 and later versions, FCNMode can be configured by using the httpRuntime settings as follows:

      <httpRuntime fcnMode="Disabled"/>

This configuration will use a single watcher for the entire directory structure. While performance may still suffer, it should prevent outright failure:

      <httpRuntime fcnMode="Single"/>


## Disabling FCN (below .NET 4.5)

1. Open Regedit.exe (not RegEdt32!)

2. Add a DWORD at HKLM\Software\Microsoft\ASP.NET\FCNMode, with a value of '1'

2. Add a DWORD at HKLM\SOFTWARE\Wow6432Node\Microsoft\ASP.NET\FCNMode, with a value of '1' (on 64-bit systems, dual entry is required)

5. Reboot (iisreset may suffice, but some users have found a reboot neccessary)

Microsoft also documents a value '2' that is supposed to use recursive monitoring and only create one FileSystemWatcher/DirectoryChangeNotification object. 

Our testing of '2' was unfortunately hindered by a simultaneous problem with IIS, so we don't know if '2' will work, or if its failure was actually IIS's web.config watcher.

This registry setting was introduced through updates, not a major release, so make sure your system is fully patched to get the best results. And share your experience and results so we have more data to draw from. 

Many companies are successfully running over 20TB of imagery through IIS and ASP.NET, so although it can be challenging, it's possible. I've helped several companies solve their IIS/ASP.NET scaling problems, so feel free to contact me at support@imageresizing.net if you have any questions.

[More information](http://blogs.iis.net/hosterposter/archive/2006/10/30/Hosting-IIS-with-UNC-content-_2D00_-Network-BIOS-commands-and-other-errors.aspx)

[Microsoft KB article](http://support.microsoft.com/?id=911272)


## Raise the command/watcher limit

Alternatively, if there is a *small* number of folders on the site, you can simply raise the number of commands. This approach doesn't tend to scale well, and still results in useless network congestion.

[See Microsoft KB 810886](http://support.microsoft.com/kb/810886)

