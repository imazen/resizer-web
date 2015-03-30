Libs: -comments

# PdfRenderer licensing


## TLDR; PdfRenderer is GPLv3 or AGPlv3, depending on which version of Ghostscript you use it with. This  affects your apps.

## The long explanation

PdfRenderer uses Ghostscript. Ghostscript v9.06 and earlier are licensed [under the GPL v3](http://www.gnu.org/copyleft/gpl.html); 9.07 and later are licensed [under the AGPL v3](/licenses/agpl).

Therefore, the PdfRenderer binaries are also made available under both the GPL v3 or the AGPL v3, as PdfRenderer (in its current form) links dynamically to the Ghostscript library. 

While the GPL v3 and AGPLv3 do not allow us to license the binaries under the MIT license 
(since they are derivative works when used with the ghostscript DLLs), 
we can license the *source* under the MIT license. 

This allows any future user to take the source code and modify it to either 

 * (a) replace Ghostscript with the BSD-licensed [PDFium (foxit)](https://code.google.com/p/pdfium/) and (optionally) LGPL-licensed [PDFiumViewer](https://github.com/pvginkel/PdfiumViewer/issues/12)
 * (b) use ghostscript via an external executable, and therefore lift the GPL v3 requirement.

Ghostscript has serious issues with multi-tenanting, and eventually
works itself into an invalid state over time, with some PDFs. PDFium might replace one set of bugs with another, but it seems like a very useful experiment, and would certainly fix the licensing issues (as would using Ghostscript in a separate process).


** Be aware that (unlike other plugins), the use of Ghostscript places restrictions on the binaries of any code 
that uses the PdfRenderer plugin; because it too becomes under the GPL (or AGPL), 
in addition to any other license it is under.**

## If you are using Ghostscript 9.06 and earlier
If you are not distributing binaries of your code which uses the PdfRenderer plugin, 
or are only using them on your web server, it is unlikely you need to be concerned about this.

## If you are using Ghostiscript 9.07 or later, OR if you are conveying/distributing your software in any way...

You will need to comply with the terms of the [AGPLv3](/licenses/agpl)

If you are interested in funding development of a GPL-free version, please contact support@imageresizing.net.

**To sum up: Compiled versions which use Ghostscript are under the GPL v3 or AGPL v3. Source is under MIT, GPL v3, or AGPL v3, your pick**. 

### Licenses

[GPL v3](http://www.gnu.org/copyleft/gpl.html).
[AGPL v3](/licenses/agpl)


## MIT License (only on source code)

Copyright (c) 2012 Jason Morse and Nathanael Jones

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
associated documentation files (the "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
 copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
 OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.