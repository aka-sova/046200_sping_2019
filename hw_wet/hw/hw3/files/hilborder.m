function imhilb = hilborder(im)
% Extract image indeces in Hilbert curve order
%
% im - input image
%
% imhilb - image in Hilbert curve order

im = im(:);
n = log2(sqrt(length(im)));
[xd,yd] = hilbertc(n);
c(:,1) = floor(((xd+0.5)*2^n)+1);
c(:,2) = 2^n - floor(((yd+0.5)*2^n)+1) + 1;

M = reshape(im,sqrt(length(im)),[]);
imhilb = zeros(1,size(c,1));
for i = 1:length(imhilb)
    imhilb(i) = M(c(i,1),c(i,2));
end
