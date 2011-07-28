# Getting a detailed error message

If some images are not displaying correctly, you must visit an image url directly to get the exact error message.

The image URL is **not** the same as the page URL. Screenshots of IE's broken image icon are not helpful in the slightest.

* In Chrome, right-click on the broken image and choose "Open image in new tab"
* In Firefox, right-click and choose "View image"
* In IE, right-click the image and choose Properties. Copy and paste the Address (URL) field contents into the address bar of a new window.

If you do not get a specific error message, you must enable detailed error messages on your ASP.NET site.

If you have local access to the server, you can set the [customErrors mode](http://msdn.microsoft.com/en-us/library/h0hfz6fc.aspx) to RemoteOnly and access the URLs using 'localhost'.

Otherwise, you may need to temporarily set customErrors to Off, so you can get error messages from a remote location. Temporarily is a key word! Detailed error messages are considered a security risk and have enabled certain types of attacks to function. They should not be enabled for more than a few hours at most on a publicly accessible server.

You may also have to **temporarily** change &lt;deployment retail to "false" for the customErrors setting to take effect. 

The customErrors setting is case-sensitive! Use "Off", "On", and "RemoteOnly".