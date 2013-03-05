
# Contribute to the project!


### Connecting to the Git repository

1. If you don't have Git installed, download "Git-1.7.6.Preview" or later from [the msysgit website](http://code.google.com/p/msysgit/downloads/list). Install it.
2.  [Download the SmartGit GUI](http://www.shareit.com/affiliate.html?affiliateid=200142144&publisherid=200020344&target=http%3A%2F%2Fwww.syntevo.com%2Fsmartgit%2Findex.html) and install it.
3. Sign up for a GitHub account, and enter your public key. If you don't know what your public key is, [download and run this tool](http://windowsgit.com/keytool) to find or generate it for you.
4. E-mail your GitHub username to `support@imageresizing.net`
5. Then, open SmartGit and `Clone` `git@github.com:imazen/resizer.git`

If you're not sharing code, simply use the NuGet packages to get the latest binaries automatically, and [configure Visual Studio to download sources and symbols](http://www.symbolsource.org/Public/Home/VisualStudio) automatically for debugging.


## Why is the repository private?

1. This repository has copyrighted image files in the history that can't legally be 'published'. In the next version I might start over with a fresh repository and rid myself of this problem.
2. The repository structure is a bit confusing - The generated packages are greatly simplified and reduce the chance of errors.
3. Each usable version gets a new release on NuGet and ImageResizing.Net immediately. The Git repo is not always in a consistent or building state, although I try to keep it that way. My build script creates and uploads new releases in minutes, so it's easier to email someone a hotfix link than direct them to the right git commit.


