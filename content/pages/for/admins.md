# It's for administrators

99% of the power of the Dynamic Image Resizing Module can be accessed through the querystring - simple name and value pairs. 

You can drop this product into ANY IIS-hosted website, and users will immediately be able to do dynamic resizing. 

Everything is configurable via XML, and there are examples so you can copy & paste. No coding required. 

## Usage

1. Take an existing image URL from an existing website, say:
	
	http://domain.com/folder/image.jpg

2. Add a '?' (this separates the file path from the querystring)
	
	http://domain.com/folder/image.jpg?

3. Add the changes you would like to make to the image in key=value form. Separate multiple pairs with '&'.
	
	http://domain.com/folder/image.jpg?width=100
	http://domain.com/folder/image.jpg?width=100&height=100

That's it. 