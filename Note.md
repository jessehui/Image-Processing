1

Image enhancement example: edge enhancement, contrast enhancement
Image enhancement is `subjective`(主观的).

Image restoration: `objective` process
Example: Deblurring, Noise filtering

Color processing:
Two types: Pseudo(假的, 伪的) color, Full color

Image Analysis:
Input: Digital Image     Output: Extracted features
Extract meaningful information from image
Example: edge detection, morphological(形态学的) processing
<br/>
<br/>
2

Raw Image: output of digital camera module
It can be in different formats, commonly it is in `Bayer` pattern of RGB

Noise detection: It is important to remove the noise before other processing to avoid amplifying the noise.

Lens correction: Light is detected differently at the sensor depending on the angle it has entered the lens.
As a result, image is distorted(扭曲的) in corner areas: `Corners` are `Darker and `Redder`.

De-mosaicing: Full color image is reconstructed from the incomplete information in Raw image. Commonly de-mosaicing process converts Bayer pattern to `full image`.

White balance: Compensate for color differences in the digital image that occur as a result of difference in `lighting conditions`.
Types of light: Fluorescent(荧光的), Natural light, LED light

Color correction: Sensor and human eye have different color sensitivity.
How it works: Take pictures of objects with well known colors (Macbeth chart). Find a mapping that will get the colors in the image to match colors in macbeth chart.

Gamma Correction:
Non-linear operations used to map color in images. It compensate for the property of human vision. Human vision follows `Non-linear` Gamma Function, while sensor following a `linear` function.

Color space: e.g. YUV (Y: luminance亮度;  U, V: chrominance色度 )
Choroid (脉络膜): Heavily pigmented membrane. Reduce the amount of extraneous(外部的) light entering the eye and backscatter(向后散射) in the globe.
<br/>
<br/>
3

Cornea(角膜)
Iris(虹膜) ：Front contains visible pigment of the eye. Back contains black pigment.

Retina
Inner most membrane. Stretches(伸展) across the entire posterior(后面的) portion of the eye. Surface of retina is covered by discrete light receptors cones(锥状) and rods(棒状).

Cones: 6-7 million in the eye. Located in the `central` portion of retina i.e. `Fovea`
`Each` cone is connected to its own nerve ending. Sensitive to `Color`. Used in `photopic` vision (bright-light vision)

Rods: 75-150 million in the eye. Spread out over `larger` area of retina. `Multiple` rods are connected to the same nerve ending. Cannot discern much detail. Used to obtain the over all image to the scene. Not used in color vision. `Scotopic` vision.

Fovea(中央凹): Muscles controlling the eye rotate the eyeball until the image of the object of interest falls on fovea.
Blind spot: On retina where optical nerve ends. No cons or rods.

Flatter the lens to focus on far objects. Thicken the lens to focus on near objects.
<br/>
<br/>
4

Human vision can adapt over very large range of light intensity levels up to 10^10. But not to the whole range `at once`.
Light intensity < Brightness adaption level - small range
=>  receive black
Light intensity >  Brightness adaption level - small range
=> visual system adapts to new brightness adaption level

Weber ratio = ```
𝛥Ic/I
```I - light source intensity  𝛥Ic - increment in light source intensity
Weber ratio describes visual system ability to discriminate between change in light intensity at a particular point. The smaller, the better (more sensitive) .

5

Commonly color temperature is associated with an illuminant.
Light emitted by black body has spectrally dominant component that moves from red to blue as temperature increase.
color is defined by `light`, `object`, `human visual system`.
<br/>
<br/>

6

Color modules:
(1)device independent: same color on all output media like XYZ(corresponding to Blue, Green, Red), xyY, L*a*b*
(2)device dependent: different color all different devices for the same color like RGB

XYZ color space:
measure the spectrum of the light source; measure the spectrum of the light reflected from the object; for each wavelength band, multiply the reflectance factor; Integrate over all the wavelength.
From XYZ to xyY: x = X/(X+Y+Z),y = Y/(X+Y+Z) means color information, Y means luminance information
<br/>
<br/>

7

CIE Chromaticity Diagram: People can only see the color inside the horse-shoe shape.
Dots near the outline represent more saturated(饱和的, 湿透的) colors.  Near the center represent washed out colors.
Ideal white is at (x,y) = (0.33,0.33) and correspond to the illuminant. Ideal black is at the same point as ideal white since CIE chromaticity diagram does not capture illuminance information.
Chromaticity diagram does not represent the color graduation uniformly. And Minimum distance between two discernible color in the left lower corner and towards the top.

L*a*b* color space results in more on uniformity.

RGB obtained by matrix operation is in range of `(0,100)`
Scale down by 100 to get values between (0,1)
Scale it up depending on the number of bits available (e.g. for 8 bits by 255)

luminance 亮度
illuminance 照明启发
<br/>
<br/>
