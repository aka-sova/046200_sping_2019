
%% THIS CODE RELATES TO QUESTION #2

%% Algorithm 1 - single image

im1 = uint8(ones(10,10))+55;
noiseSignal = uint8(rand(10, 10).*10);
% add gauss noise
im1 = im1 + noiseSignal;

im1(5,5) = im1(5,5)*2;
im1(8,7) = im1(8,7)*2;


im2 = padarray(im1,[1 1],'replicate','both');

filter = (1/8)*[1 1 1; 1 -4 1; 1 1 1];

im_filtered = imfilter(im2,filter);
im_filtered_2 = im_filtered(2:end-1,2:end-1); % unpad

threshold = uint8(5);

% use the threshold to binalize the image
im_filtered_3 = imbinarize(im_filtered_2,im2double(threshold));

% plot to see results
imshow(im_filtered_3)


%% Algorithm 2 - two images

% set the threshold 

threshold = uint8(20);
image_size = 5;

im1 = uint8(ones(image_size,image_size))+55;
noiseSignal = uint8(rand(image_size, image_size).*10);
% add gauss noise
im1 = im1 + noiseSignal;

% add failed pixels
im1(5,5) = im1(5,5)*2;
im1(2,3) = im1(2,3)*2;

% image 2 has other pixel which fails
im2 = uint8(ones(image_size,image_size))+55;
noiseSignal = uint8(rand(image_size, image_size).*10);
% add gauss noise
im2 = im2 + noiseSignal;

% add failed pixels
im2(1,1) = im2(1,1)*2;

difference_matrix = abs(im2double(im1) - im2double(im2));
difference_bin = imbinarize(difference_matrix,im2double(threshold));


%% Algorithm 3 - fix the image when the failed pixel coordinates are known

image_size_x = 3;
image_size_y = 3;
failed_pixels{1} = [2 3];

im3 = uint8(ones(image_size_x,image_size_y))+55;
noiseSignal = uint8(rand(image_size_x, image_size_y).*10);
% add gauss noise
im3 = im3 + noiseSignal;



for i=1:numel(failed_pixels)
    im3(failed_pixels{i}(1),failed_pixels{i}(2)) =...
        im3(failed_pixels{i}(1),failed_pixels{i}(2))*2;
end

im3_col_order = reshape(im3,[numel(im3) 1]);

A = create_fixing_matrix([image_size_x, image_size_y], failed_pixels);

im3_fixed_col_order = im2uint8(A*im2double(im3_col_order));
im3_fixed = reshape(im3_fixed_col_order,[image_size_x, image_size_y]);



%% Algorithm 4 - change the column ordered matrix to row ordered


image_size_x = 3;
image_size_y = 3;

im4 = uint8(ones(image_size_x,image_size_y))+55;
noiseSignal = uint8(rand(image_size_x, image_size_y).*10);
% add gauss noise
im4 = im4 + noiseSignal;

im4_row_order = reshape(im4',[numel(im4') 1]);
im4_col_order_check = reshape(im4,[numel(im4) 1]);

C = create_row_to_col_order_matrix(im4_row_order);

im4_col_order = im2uint8(C*im2double(im4_row_order));

