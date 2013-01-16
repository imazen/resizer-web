Flags: hidden

# Optimizing IIS for use with RemoteReader and S3Reader

S3Reader and RemoteReader connect to remote servers to download files. As these connections may be high-latency, and individual requests may be long-running, additional configuration may be required to achieve optimal throughput. 

These instructions are taken [from Thomas Marquardt's excellent post](http://blogs.msdn.com/b/tmarq/archive/2007/07/21/asp-net-thread-usage-on-iis-7-0-and-6-0.aspx).

# IIS 6

.NET 2.0 defaults to 

http://support.microsoft.com/kb/821268


http://msdn.microsoft.com/en-us/library/7w2sway1(vs.80).aspx



# IIS 7

1. Switch the application pool to .NET 4.0. .NET 4 has much better defaults, and requires no changes. Alternatively:
		For v2.0 and v3.5 set a DWORD registry value @ HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ASP.NET\2.0.50727.0\MaxConcurrentRequestsPerCPU = 5000.  Restart IIS
		For v3.5, you can  set <system.web><applicationPool maxConcurrentRequestsPerCPU="5000"/></system.web> in the aspnet.config file.  If the value is set in both places, the aspnet.config setting overrides the registry setting.

2. Increase the HTTP.sys queue limit, which has a default of 1000.  If the operating system is x64 and you have 2 GB of RAM or more, setting it to 5000 should be fine.  If it is too low, you may see HTTP.sys reject requests with a 503 status.  Open IIS Manager and the Advanced Settings for your Application Pool, then change the value of "Queue Length".




If your ASP.NET application is using web services (WFC or ASMX) or System.Net to communicate with a backend over HTTP you may need to increase connectionManagement/maxconnection.  For ASP.NET applications, this is limited to 12 * #CPUs by the autoConfig feature.  This means that on a quad-proc, you can have at most 12 * 4 = 48 concurrent connections to an IP end point.  Because this is tied to autoConfig, the easiest way to increase maxconnection in an ASP.NET application is to set System.Net.ServicePointManager.DefaultConnectionLimit programatically, from Application_Start, for example.  Set the value to the number of concurrent System.Net connections you expect your application to use.  I've set this to Int32.MaxValue and not had any side effects, so you might try that--this is actually the default used in the native HTTP stack, WinHTTP.  If you're not able to set System.Net.ServicePointManager.DefaultConnectionLimit programmatically, you'll need to disable autoConfig , but that means you also need to set maxWorkerThreads and maxIoThreads.  You won't need to set minFreeThreads or minLocalRequestFreeThreads if you're not using classic/ISAPI mode.

If your application sees a large number of concurrent requests at start-up or has a bursty load, where concurrency increases suddenly, you will need to make the application asynchronous because the CLR ThreadPool does not respond well to these loads.  The CLR ThreadPool injects new threads at a rate of about 2 per second.  This is true for all versions of the CLR (v1.0 thru v4.0) at the time of this writing.  If concurrency is bursty and the request thread blocks (e.g. on a backend with latency), the injection rate of 2 threads per second will make your application respond very poorly to this work load.  The fix is to stop blocking on threads by using asynchronous I/O to communicate with the backend with latency.  If you cannot make the application asynchronous, you will need to increase minWorkerThreads.  I don't like to increase minWorkerThreads.  It has a side effect on high-throughput synchronous requests that don't block on threads, because the thread count is artificially high.