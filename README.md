#                                           Image Processing Projects

Some basic code to solve problems of image processing without toolbox in MATLAB

##Problem 1
Write code (to be submitted) to perform global histogram equalization. Use it to equalize the image “white_house256.jpg”. Plot the histograms of the image before and after equalization and also print the images before and after equalization.
![image](https://github.com/jessehui/Image-Processing/blob/master/src/white_house256.jpg)


###result:


##Problem 2
Write a code that performs local histogram equalization with a window of 15x15 pixels on the image  “white_house256.jpg”. Plot the histograms of the images before and after equalization and also print the images before and after equalization. To avoid tiling effects perform the equalizations with overlapped windows.

![image](https://github.com/jessehui/Image-Processing/blob/master/src/white_house256.jpg)

###result:


##Problem 3
Analyze the noisy image “nasaNoise.jpg” and find the properties of the interference noise. Design a filter to remove the interference. Plot the Fourier transform of the filter in 3D and print the image before and after filtering. Explain in detail your analysis and design.

![image](https://github.com/jessehui/Image-Processing/blob/master/src/nasaNoise%20_1_.jpg)

###Analysis:
We can see from the picture that the noise in the picture is periodical, which means there are some specific frequencies in the frequency domain becoming noise in this picture. To eliminate the periodical noise, we should eliminate some specific frequencies in the frequency domain. Thus, we should use notch filter.

###result:


##Problem 4
Design the best filter to remove the shot noise from the image “LenaDeltaNoise.jpg”. Select various sizes of the filter and try to find the optimal size. Explain your design and print the results with several such filters.
![image]()

###Analysis:
The noise of the picture LennaDeltaNoise seems like the shot noise which can be eliminated by average filter or median filter.

###result:


##Problem 5
The image “PeanutRotated.jpg” is distorted by rotation, translation and scaling. Write a program to restore the given image using bilinear interpolation. Display the restored image and the given image. Detail the design parameters you used for the restoration.

![image](https://github.com/jessehui/Image-Processing/blob/master/src/PeanutRotated-B.jpg)

###result:

