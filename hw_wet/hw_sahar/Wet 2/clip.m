function clpim = clip(im,varargin)
% CLIP performs dynamic range clipping to the image.
%
% im       - Input image
% varargin - Optional, Dynamic range to clip into (default [0 255])
% clpim    - Clipped image
%

clpim = im;

if nargin>1
    range = varargin{1};
else
    range = [0 255];
end

clpim(clpim<range(1)) = range(1);
clpim(clpim>range(2)) = range(2);
