
# Cropping with the ImageResizer



The URL syntax for cropping is `crop=x1,y1,x2,y2`. The coordinates are relative to the top-left corner of the original image - if they are positive values.

If X2 or Y2 are 0 or less, they are relative to the bottom-right corner. This allows easy trimming without knowing the size of the image.

For example, crop=0,0,0,0 leaves the image uncropped. crop=10,10,-10,-10 removes 10 pixels from all edges of the image.


In addition, you can specify `cropxunits` and `cropyunits`. Setting them to 100 allows you to crop by percentage. Setting them to the width/height of the display image allows you to crop in display coordiantes, without needing to know the original size of the image.