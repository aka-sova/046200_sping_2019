%% INFO
% 
% Author: Alexander Shender
% ID: 328626114
%
%%  Question 4 - a 


image_1     = imread('..\rice.jpg');

figure_4_a	= figure('Name','Question 4-a');
imshow(image_1);
title('Rice original image');

figure_4_a_2	= figure('Name','Question 4-a');
histogram(image_1(:));
title('Histogram of rice image');


%%  Question 4 - b

small_image_size = [16 16];
transformed_image = find_image_segment_min(image_1,small_image_size);

figure_4_b	= figure('Name','Question 4-b');
imshow(transformed_image);
title('Minimal values per 16x16 segment');


%%  Question 4 - c

refined_image = image_1 - transformed_image;

figure_4_c	= figure('Name','Question 4-c');
imshow(refined_image);
title('Rice refined image');

figure_4_c_2	= figure('Name','Question 4-c');
histogram(refined_image(:));
title('Histogram of refined image');


%%  Question 4 - d

contrast_adjusted = imadjust(refined_image);
figure_4_d	= figure('Name','Question 4-d');
imshow(contrast_adjusted);
title('Rice refined & contrast adjusted');

figure_4_d_2	= figure('Name','Question 4-d');
histogram(contrast_adjusted(:));
title('Histogram of refined & contrast adjusted');


%%  Question 4 - e

binarized_image = imbinarize(contrast_adjusted,0.5);

figure_4_e	= figure('Name','Question 4-e');
imshow(binarized_image);
title('Rice binarized image');

mask = uint8(binarized_image);
mask_applied_image = contrast_adjusted.*mask;
figure_4_e	= figure('Name','Question 4-e');
imshow(mask_applied_image);
title('Mask applied image');













