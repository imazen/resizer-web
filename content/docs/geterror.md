# Getting a detailed error message

If some images are not displaying correctly, you *must* visit the image url directly to get the exact error message.

The image URL is **not** the same as the page URL; viewing the broken image icons on the parent page doesn't tell us anything useful.

## How to open the image URL directly

* In Chrome, right-click on the broken image and choose "Open image in new tab"
* In Firefox, right-click and choose "View image"
* In IE, right-click the image and choose Properties. Copy and paste the Address (URL) field contents into the address bar of a new window.

## Once you're viewing the image URL directly

If you do not get a specific error message, you must enable detailed error messages on your ASP.NET site.

If you have local access to the server, you can set the [customErrors mode](http://msdn.microsoft.com/en-us/library/h0hfz6fc%28v=vs.100%29.aspx) to RemoteOnly and access the URLs using 'localhost'.

Otherwise, you may need to temporarily set customErrors to Off, so you can get error messages from a remote location. Temporarily is the key word! Detailed error messages are considered a security risk and have enabled certain types of attacks to function. They should not be enabled for more than a few hours at most on a publicly accessible server.

You may also have to **temporarily** change &lt;deployment retail to "false" for the customErrors setting to take effect. 

The customErrors setting is case-sensitive; use "Off", "On", and "RemoteOnly".