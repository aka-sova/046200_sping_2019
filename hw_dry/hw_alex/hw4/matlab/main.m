


img = imread('img.png');

img = rgb2gray(img);
img = imbinarize(img);


img = (img-1)*-1;

orig_non_zeros = count_non_zeros(img);


h = 1/5*ones(5,1);
H = h*h';
% im be your image
imfilt = imbinarize(imfilter(img,H,'same','replicate'));
filtered_non_zeros = count_non_zeros(imfilt);