
# Contribute to the project!

The ImageResizing.NET project isn't just about resizing. We're Photoshop as a web-service, but with a plugin mode so things don't get bloated. I typically spend between 65 and 90 hours per week on the project, so any help you can provide is greatly appreciated.

## Sharing code

We happily accept (and use!) most contributions and patches we receive. We accept .zip files, but it's better if you send a pull request through GitHub.

### Connecting to the Git repository

1. If you don't have Git installed, download "Git-1.7.6.Preview" or later from [the msysgit website](http://code.google.com/p/msysgit/downloads/list). Install it.
2.  [Download the SmartGit GUI](http://www.shareit.com/affiliate.html?affiliateid=200142144&publisherid=200020344&target=http%3A%2F%2Fwww.syntevo.com%2Fsmartgit%2Findex.html) and install it.
3. Sign up for a GitHub account, and enter your public key. If you don't know what your public key is, [download and run this tool](http://windowsgit.com/keytool) to find or generate it for you.
4. E-mail your GitHub username to `support@imageresizing.net`
5. Then, open SmartGit and `Clone` `git@github.com:imazen/resizer.git`

If you're not sharing code, simply use the NuGet packages to get the latest binaries automatically, and [configure Visual Studio to download sources and symbols](http://www.symbolsource.org/Public/Home/VisualStudio) automatically for debugging.


## What we need

### Website & community

1. Writers - We need more how-to articles, in more .NET languages! We can post them here, or link to your blog - doesn't matter. Show people how to do zoomable product images, image galleries, slideshows, lightbox, etc..

2. Designers - This website is a bit... uh... boring. That's what happens when I try my hand at design. A better sales pitch could really help the project, maybe even allow me to hire some badly needed help. I get a lot of traffic, so this could help both of us.

3. Webmasters - This website is mostly written in Markdown & HAML, and runs on the awesome micro-CMS [Nesta](http://nestacms.com). It's a lot of fun to work with, and quite flexible. It's in a Git repository, and easy to collaborate on. Any time you can spare to help with the todo list is appreciated!

4. Translators - Less than half of paying customers speak English as a first language. Why not help bring the project to your native tongue?

### Core project development

1. MVC support is very minimal right now. I've been working on a url generation system for a few months, but I need more feedback before I publish an API. After that, I can get back to ActionResult support. If you're an MVC expert with a little bit of free time, I'd love to have your assistance.

### Plugin development

See something on the [ideas forum](http://resizer.uservoice.com) that interests you? The plugin model means you can implement it independently. If it's general-purpose enough, I might put it in the standard download. 

### Wrappers

We try to make the URL API human-friendly, but most people prefer wrappers. We don't have very many. 

The [fledgling StudioJS project](https://github.com/nathanaeljones/studiojs) is an attempt to rectify this, but we need MVC and WebForms wrappers for the jQuery libraries. [CropImage.NET](http://cropimgae.net) is a WebForms control wrapping jCrop and ImageResizing.NET, but was designed to be compatible with the legacy WebCropImage control by Cem Sisman. 

If you're interested in making WebForms or MVC wrappers for the web service, we're interested in promoting them and helping you.

See the [wrappers page for a current list](/dosc/wrappers).

### CMS Integration

Our goal is to support every CMS. And, we do, generally. But there's a lot of value in having deeper integration, so you don't have to manually add the querystring.

Dozens of CMSes have integrated the Core library natively, and we encourage that. Plugins have to be separately purchased, but they're quite affordable, and aren't usually needed for intranet or private installations.

Provide an open-source module that provides stronger integration between a CMS and ImageResizer, and you could be eligible for a free enterprise license or a 2YR Bronze support contract.

## Why is the repository private?

1. This repository has copyrighted image files in the history that can't legally be 'published'. In the next version I might start over with a fresh repository and rid myself of this problem.
2. The repository structure is a bit confusing - The generated packages are greatly simplified and reduce the chance of errors.
3. Each usable version gets a new release on NuGet and ImageResizing.Net immediately. The Git repo is not always in a consistent or building state, although I try to keep it that way. My build script creates and uploads new releases in minutes, so it's easier to email someone a hotfix link than direct them to the right git commit.


