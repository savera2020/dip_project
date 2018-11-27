# dip_project
### Road detection with radon transfom approximation
The project is to implement the Radon transform to segment the road from remote sensing images.
Implementation of a dictionary learning method to approximate the Radon transform 

### code run procedure 

main.m  main function accept the image directory path and perform the radon transform and radon approximation.

function radon_transform.m  perform the radon transform -- inputs image_matrix, true/false flag -- output radon transform result.

function radon_training_data.m  generate the training data -- inputs path to image folder -- output training data generation.

radon_approximation.m implemented closed form MSE solution and save the weights

function radon_approximation_test.m inference the radon approximation --input binary_image, weights -- output radon approximation result.



**data set taken from** [link](http://weegee.vision.ucmerced.edu/datasets/landuse.html)

**Matlab reference** [link](https://in.mathworks.com/help/images/detect-lines-using-the-radon-transform.html)


**Results**


![Radon transform](https://github.com/savera2020/dip_project/tree/master/result/3.jpg)
![Radon approximation](https://github.com/savera2020/dip_project/tree/master/result/3_C.jpg)
