

%% INFO
% 
% Author: Alexander Shender
% ID: 328626114
%
%%  Question 1 - a 

image_1 = imread('..\Anna.jpg');

% use the fft2 to execute the fourier 2d transform
% use fftshift to center the lowest frequencies to the center

fft_2d = fftshift(fft2(image_1));

% use the log to decrease the contrast
log_spectrum = log(1+abs(fft_2d));

% rescale the result in order to be able to show an image
log_spectrum = uint8(rescale(log_spectrum,0,255));



figure_1_a = figure('Name','Question 1-a');
subplot(1,2,1);
imshow(image_1);
title('Original image (Anna)');
subplot(1,2,2);
imshow(log_spectrum)
title('Log spectrum of the image');


%%  Question 1 - b


% fetch 4% of the lowest frequencies
% since lowest are in the middle, take 4% of the middle rows
% for X and Y direction

% creating a mask for this

[rows_num, cols_num] = size(fft_2d);
mask = zeros(rows_num, cols_num);

% fine the number of rows & columns to leave untouched
save_percent = 4;
rows_to_leave = round(rows_num*save_percent*0.01);
cols_to_leave = round(cols_num*save_percent*0.01);

% make those 1
mask((rows_num/2)-(rows_to_leave/2):(rows_num/2)+(rows_to_leave/2),:) = 1;
mask(:,(cols_num/2)-(cols_to_leave/2):(cols_num/2)+(cols_to_leave/2)) = 1;

% apply the filter
log_spectrum_filtered = log_spectrum.*uint8(mask);


% to make the reversing easier, we apply the same mask on the fft2
% transform without the log spectrum - it was made only for the
% vizualization. 

fft_2d_filtered = fft_2d.*mask;

% reverse back, not forgetting to shift, and to use the absolute value
restored_image = uint8(abs(ifft2(ifftshift(fft_2d_filtered))));


figure_1_b = figure('Name','Question 1-b');
subplot(2,2,1);
imshow(image_1);
title('Original image (Anna)');
subplot(2,2,2);
imshow(mask)
title('Mask applied on the Fourier Transform');
subplot(2,2,3);
imshow(fft_2d_filtered)
title('Fourier transform after mask');
subplot(2,2,4);
imshow(restored_image)
title('Restored image');




%%  Question 1 - c

% auxiliary calculation for answer - calculating the nonzero elements in
% the filtered 2d transform

non_zero_elems = nnz(fft_2d_filtered);
percent_of_memory_real = 100*(non_zero_elems/length(image_1(:)));

% or by calculating analytically
save_part = save_percent*0.01;
percent_of_memory_analytical = 100*(save_part+save_part-(save_part^2));



%%  Question 1 - d

% finding the dominant frequencies in columns

cols_sum = abs(sum(fft_2d,1));
[~,i_sorted_cols] = sort(cols_sum);

% take 4% of the last indexes
save_percent = 4;
cols_to_leave = round(length(i_sorted_cols)*save_percent*0.01);

% find the dominant columns
dominant_columns_indexes = i_sorted_cols(length(i_sorted_cols)-cols_to_leave+1:length(i_sorted_cols));



%%  Question 1 - e

% finding the dominant frequencies in rows

rows_sum = abs(sum(fft_2d,2));
[~,i_sorted_rows] = sort(rows_sum);

% take 4% of the last indexes
save_percent = 4;
rows_to_leave = round(length(i_sorted_rows)*save_percent*0.01);

% find the dominant columns
dominant_rows_indexes = i_sorted_rows(length(i_sorted_rows)-rows_to_leave+1:length(i_sorted_rows));



%%  Question 1 - f

% we create a mask from previously found dominant frequencies in X and Y
% directions
mask = zeros(rows_num, cols_num);

mask(:,dominant_columns_indexes) = 1;
mask(dominant_rows_indexes,:) = 1;

% same as before - apply this mask to the Fourier transform, and
% use the inverse fft matlab function

fft_2d_filtered = fft_2d.*mask;

% reverse back, not forgetting to shift, and to use the absolute value
restored_image_2 = uint8(abs(ifft2(ifftshift(fft_2d_filtered))));


figure_1_f = figure('Name','Question 1-f');
subplot(2,2,1);
imshow(image_1);
title('Original image (Anna)');
subplot(2,2,2);
imshow(mask)
title('Dominant Frequencies mask');
subplot(2,2,3);
imshow(fft_2d_filtered)
title('Fourier transform after mask');
subplot(2,2,4);
imshow(restored_image_2)
title('Restored image');


figure_1_f_2 = figure('Name','Question 1-f-comparison');
subplot(1,2,1);
imshow(restored_image)
title('Restored image (lowest frequencies)');
subplot(1,2,2);
imshow(restored_image_2)
title('Restored image (dominant frequencies)');



%%  Question 1 - g

% find the 8% of dominant frequencies

% first, reshape the original fft2 matrix
fft2_reshaped = reshape(fft_2d,length(fft_2d(:)),1);
[~,i_max_vals] = sort(abs(fft2_reshaped));

save_percent = 8;
pixels_to_leave = round(length(fft_2d(:))*save_percent*0.01);

indexes_to_leave = i_max_vals(length(fft2_reshaped)-pixels_to_leave+1:length(fft2_reshaped));

% create the mask
mask = zeros(length(fft2_reshaped),1);
mask(indexes_to_leave) = 1;
mask = reshape(mask,rows_num,cols_num);

fft_2d_filtered = fft_2d.*mask;

% reverse back, not forgetting to shift, and to use the absolute value
restored_image_3 = uint8(abs(ifft2(ifftshift(fft_2d_filtered))));


figure_1_f = figure('Name','Question 1-g');
subplot(2,2,1);
imshow(image_1);
title('Original image (Anna)');
subplot(2,2,2);
imshow(mask)
title('Overall Dominant Frequencies mask');
subplot(2,2,3);
imshow(fft_2d_filtered)
title('Fourier transform after mask');
subplot(2,2,4);
imshow(restored_image_3)
title('Restored image');







