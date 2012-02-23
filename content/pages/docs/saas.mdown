
# Hosted Image Processing

Why maintain your own installation of the ImageResizer & Plugins? A hosted solution can provide much greater scalability, better performance, and much lower costs. 

## Features

* CloudFront integration by default. Visitors get edge-cached data faster over the entire globe.
* Amazon S3 backed. No more struggling with SANs and the ASP.NET subfolder limit. Scale to millions, even hundreds of millions of images without a single NetBios error. 
* AutoScaling - handle getting [Slashdotted or Dugg](http://en.wikipedia.org/wiki/Slashdot_effect) like a pro.
* Manage plugin configuration from a web interface instead of through Web.config
* Use $1000 worth of plugins without paying license fees.
* Automatic version upgrades and server maintenance.

## Goals 

We need 25 people or more to pledge support for a region to get started. The base monthly fee is $50 for US/EU, $80 for Asia/South America. If 25 people pledge to sign up for a year, we can start up the service with confidence that it will stay running. Once more users come on board and our costs decrease, we will lower the monthly rate as much as possible.

## Get mailing listed!

Find out when the hosted version is arriving, ask questions, and give feedback.

<table border=0 style="background-color: #fff; padding: 5px;" cellspacing=0>
  <tr><td>
  <img src="http://groups.google.com/intl/en/images/logos/groups_logo_sm.gif"
         height=30 width=140 alt="Google Groups">
  </td></tr>
  <tr><td style="padding-left: 5px">
  <b>Subscribe to Hosted Image Processing</b>
  </td></tr>
  <form action="http://groups.google.com/group/hosted-imageresizing/boxsubscribe">
  <tr><td style="padding-left: 5px;">
  Email: <input type=text name=email>
  <input type=submit name="sub" value="Subscribe">
  </td></tr>
</form>
<tr><td align=right>
  <a href="http://groups.google.com/group/hosted-imageresizing">Visit this group</a>
</td></tr>
</table>

Once you're subscribed, send an e-mail to the group pledging you'll sign up for 1 year or more, and listing which AWS Region you're pledging for. If over 25 people pledge for a region, we'll offer support in that region.

## Regions

Why does the region matter? Because the closer you are to your S3 buckets, the faster you'll be able to access them. It's also important to keep the EC2 instances and S3 buckets as close together as possible for optimal performance.

Here are the EC2/S3 Regions. CloudFront offers [edge caching in 26 locations](http://aws.amazon.com/cloudfront/#details), and isn't relevant here.

* US-East (Northern Virginia)
* US-West (Northern California)
* US-West (Oregon)
* Europe (Ireland)
* Asia Pacific (Singapore)
* Asia Pacific (Tokyo)
* South America (San Paulo)

## Design

1. Original images are located on redundant Amazon S3 storage. [$1 gets you 8GB of storage per month](http://aws.amazon.com/s3/). 
2. Edge caching provided by CloudFront. $1 gets you 8GB of delivered imagery in the US/Europe regions (roughly 50k image impressions or 800k thumbnail views) and 4GB in South America (the most expensive region).
3. The ImageResizer runs on an EC2 cluster, gets requests from CloudFront, pulls originals from S3, performs the requested processing, and sends them back to CloudFront. 

## Billing

* Your AWS account will be used for S3 and CloudFront usage, so we don't need to bill for that. 
* We pay EC2, ELB, and CloudWatch fees directly. We have to charge a monthly fee for this.

## Our costs

* Our EC2 instances will be doing the image processing. Estimated minimum EC2 cost per region is $748/month (2 Large instances).
* $21 per month per region plus $8 per terabyte processed for Elastic Load Balancing and CloudWatch
* The human cost - developing the multi-tenanting system, building the Admin interface for configuration, and designing the automatic scaling system. 

## Monthly pricing

The last thing I want to do is create an SaaS product that doesn't last. I'd rather ensure that I can afford to keep the lights on than have to apologize later.

And I [definitely don't want to raise prices on existing customers, violating the golden rule of SaaS](http://www.uservoice.com/blog/index.php/entries/vendor-leave-those-customers-alone/?utm_campaign=directmail&utm_medium=email&utm_source=basic_plan_free).

So I'm starting with a flat fee of $50/month for US/Europe regions, and $80/mo for Asia and South American regions.

Companies processing over 100 gigapixels per month will have to ask for custom pricing (cached imagery not counted in the 100 gigapixel limit). 

Hopefully, once things are running smoothly, we will have enough density to lower the monthly base price for everyone to $30/month. 

## How much could I potentially pay for my S3 and CloudFront usage?

[Use the calculator](http://calculator.s3.amazonaws.com/calc5.html). Here's a few guidelines, though, based on my experience.

* I pay $1.86 per month for CloudFront (with 41k page views per month), $0.14 for S3, and $88/mo for EC2. 
* A $10 CloudFront bill means you're probably getting 200 to 500k page views per month.
* If you have 10GB of imagery, you'll pay $0.50 to $1.
* If you have 1TB of imagery, you'll probably pay about $130/mo to host it on S3.