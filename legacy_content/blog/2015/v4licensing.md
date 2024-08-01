Date: May 1 2015
Summary: ImageResizer v4 brings licensing changes

# ImageResizer v4 brings licensing changes

Hello again! ImageResizer v4 is just about ready for release, and it's faster and better than ever before. In fact, if you would like to purchase a v4 license just to be ready when it comes out (also valid for v3 in the meantime), you can visit our [store page](https://store.imazen.io/) now and do just that.

While you're in checkout, you might notice a strange new step in the process: license key generation. That's right, some premium plugins in v4 will be DRM-enabled, but do not fret and do not fear. In case you're particularly predisposed to fretting and fearing, however, we at Imazen have created a helpful list of fret and fear deterrents:

1. Everything in v4 is now published under an OSI-approved open-source license. Everything that was free in v3 is now [Apache 2 licensed](/licenses/apache) in v4. Everything that was paid in v3 can be used in v4 under the terms of the [AGPL v3](/licenses/agpl). The AGPL v3 typically requires your entire web app to be open sourced. We continue to offer a wide range of commercial licenses for those who do not wish to comply with the terms of the AGPLv3. Commercial licenses include [domain-specific](/licenses/domain), [enterprise-wide](/licenses/enterprise), [OEM redistributable, SaaS resale](/licenses/oem), [development shop redistributable](/licenses/enterprise), and [trial licenses](/licenses/trial).

1. If license key validation fails, a red dot will appear on your images, but nothing will "stop working". You can still use premium plugins for development and testing without a purchase.

2. After checkout, you can verify your license key works by [adding it to Web.config](/docs/v4/install/license_keys) and visiting the ImageResizer diagnostics page `/resizer.debug`. It should explain which functionality your license includes. License key validation is done offline using public-key cryptography; it does not use the network.

3. You can access DRM-free nuget pacakges, source, and binaries if you have an Elite, OEM or SaaS license or a support contract. 

4. None of our licenses prohibit removal of the DRM. Removing the DRM doesn't free you from copyright law and the license terms (whether AGPL or commercial), it just means you won't be reminded to comply with them. It's also our tricky way to get you hooked on editing the source code (and, hopefully, sending us pull requests on GitHub).


Furthermore, in response to customer demand, we have created a special, fixed-price [OEM/SaaS support contract](/support/contracts/oem) specifically for users wishing to use an [OEM/SaaS license](/licenses/oem).

That's all the news for now. Thank you all for your patience. It'll be worth the wait.


&mdash; Liz Certa