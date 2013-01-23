Title: Support - Image Resizer
Libs: uservoice, -comments

#Support

When contacting support about a problem, *please* include (a) the [diagnostics page output](/plugins/diagnostics), and (b) [the precise error message you get when you put the image URL directly into the address bar](/docs/geterror). Without this information, **we cannot diagnose the problem**. It's also a good idea to skim the [troubleshooting page](/docs/troubleshoot), as there's a good chance it covers your issue.

<script language="javascript">
function isDstInEffect(off){
	var d = new Date();
	//get the start and end dates for dst:(these rules are US only)
	var     y= d.getUTCFullYear(), countstart= 8, countend= 1,
	dstart= new Date(Date.UTC(y, 2, 8, 2, 0, 0, 0)),
	dend= new Date(Date.UTC(y, 10, 1, 2, 0, 0, 0));
	while(dstart.getUTCDay()!== 0) dstart.setUTCDate(++countstart);
	while(dend.getUTCDay()!== 0) dend.setUTCDate(++countend);

	//get the GMT time for the localized dst start and end times:
	//dstart.setUTCMinutes(off);
	//dend.setUTCMinutes(off);

	// if the date passed in is between dst start and dst end, adjust the offset and label:
	return (dstart<= d && dend>= d);
}
var now = new Date();


var edtOffset = isDstInEffect(-5 * 60) ? -4: -5;//-4, -5
var localOffset = now.getTimezoneOffset() / -60;

var a = (localOffset - edtOffset + 9) % 24;
var b = (localOffset - edtOffset + 21) % 24;

var mins =  now.getMinutes().toString(); 
if (mins.length == 1) mins = mins + '0';

document.write("For the quickest response, please contact support between <strong>" + a + ":00 and " + b + ":00</strong> based on your estimated local time of " + now.getHours() + ":" + mins + ". This is 9am to 9pm EDT (my time zone).");
</script>

Email:  **support@imageresizing.net**. If you do not immediately get an automated reply, your e-mail *did not arrive*. 

Both online tickets and this e-mail address are immediately forwarded to my personal e-mail account, so please use them! It helps me track support requests in a more organized manner. If you e-mail me at my personal e-mail address (nathanael.jones@gmail.com), your request may get lost!

[Submit new ideas or vote for existing ones at the uservoice site](http://resizer.uservoice.com/forums/108373-image-resizer-v3).

If you post a question on StackOverflow, please [tag it 'imageresizer'](http://stackoverflow.com/questions/tagged/imageresizer) and *always* include the diagnostics page output. Please send a link to support@imageresizing.net, as we're often interested in providing an official answer. And if we take the time to provide a good answer to your question, please be courteous; both mark it as the answer and vote it up.

## Buy a support incident

Priority email, phone and TeamViewer support costs $135/incident. A [30-minute Q&A session costs $70](/support/consult), but (unlike) a support incident, is time-limited and only reccomended for consulting/introduction purposes.

If you work for a business, please [look at the support contract options](/support/contracts) - they can provide significant savings. 

It is suggested that you download and install [Team Viewer](http://teamviewer.com) on the computer in question, as remote desktop access may be required to resolve your issue.

Credit cards, PayPal, and Google Checkout are accepted.

<form action="https://www.e-junkie.com/ecom/gb.php?c=cart&amp;i=939690&amp;cl=41912&amp;ejc=2" target="ej_ejc" method="POST" accept-charset="UTF-8">
Support Type<br/>
<select name="o1">
<option value="30 Minute QA">30 Minute QA ($70)</option>
<option value="1 Aided install + 30 Minute QA">1 Aided install + 30 Minute QA ($130)</option>
<option value="2 Aided installs + 30 Minute Q&amp;A">2 Aided installs + 30 Minute Q&amp;A ($190)</option>
<option value="Support Incident (Business)">Support Incident ($135)</option>
</select>

<input type="image" src="http://www.e-junkie.com/ej/ej_add_to_cart.gif" border="0"  alt="Add to Cart" class="ec_ejc_thkbx" onClick="javascript:return EJEJC_lc(this.parentNode);"/>
<a href="https://www.e-junkie.com/ecom/gb.php?c=cart&amp;cl=41912&amp;ejc=2" target="ej_ejc" class="ec_ejc_thkbx" onClick="javascript:return EJEJC_lc(this);"><img src="http://www.e-junkie.com/ej/ej_view_cart.gif" border="0" alt="View Cart"/></a>
</form>

<script language="javascript" type="text/javascript">
<!--
function EJEJC_lc(th) { return false; }
// -->
</script>
<script src='http://www.e-junkie.com/ecom/box.js' type='text/javascript'></script>

## Eligible for priority e-mail, phone or TeamViewer support?

* Own a license purchased before Apr. 20th, 2012. Licenses purchased after this date only include 1 incident.
* Have a [valid support contract](/support/contracts).
* Be an open-source developer leveraging the ImageResizing.NET project in another open-source project
* Blog about the project and refer at least 300 visitors to the website.

If you're not in one of the above categories, you'll need to buy a support incident above.

## Free support is only provided for the URL API

If you need help with the Managed API or need an immediate answer, get a support incident. Paid support requests are usually answered within 45 minutes and most are resolved within 1 hour. 

Free e-mail support is provided on a best-effort basis. Expect a response within 1 week of submitting your question. 

Why did I cancel free support for the managed API? Because users can invent creative ways to fail faster than I can document them. **If I suspect you've actually found a bug, I'll help you, and even pay you a bounty if it's legit.** But it's much more likely you're just having a bad day.

Here's a list of *Really Bad Ideas*:

* **Not installing the MvcRoutingShim on an ASP.NET project that uses Routing**. Of course nothing is going to work right when 2 HttpModules are both trying to answer the same request.
* **Implementing your own disk caching system**. Disk caching is not an IF statement. If you think you can do a secure implementation in under 5KLOC, you don't understand the problem space.
* **Wrapping the managed API in an ActionResult or custom HttpHandler**. MVC is cool stuff. But like ALL OTHER FRAMEWORKS, it is [**very** bad at serving static files or doing image processing](/docs/mvc). It's designed for HTML, XML, and JSON. There are several dozen very good reasons why you need an HttpModule for this kind of stuff. HttpHandlers and ActionResults are both inherently terrible at static file serving and disk cached processing.
* **Batch processing images inside a request thread**. If you possibly can, give each image a separate request so it has a chance at succeeding in bad conditions. 
* **Trying to batch process multiple images inside a request thread in parallel**. A single image can require 50-200MB of RAM to process. And you want to do them 50 at a time? It's wasteful and will actually take longer. This is not client side development; throughput and stability trumps theoretical response time. 
* **Touching any System.Drawing class directly from a server app**. It's just plain dumb unless you come from a heavy Win C++ background. 95% of all server-side memory leaks occur this way.
* **Re-using the original filename (or extension) of an image upload when saving it to disk. That's instant root access for any elementary school kid who notices.** 
* **Building your own SQL/S3/Azure/GridFS/RemoteURL -> Managed API bridge instead of using the existing datastore plugins**. Nothing is simple when you're dealing with images of arbitrary size and format, not even a basic SQL call. 

I've made [a plugin](/plugins) for nearly every situation, and they're [easy to make yourself](/docs/plugins/basics) as well. 

And, if all else fails, [try reading the docs](/docs) or [searching the site](/search).

