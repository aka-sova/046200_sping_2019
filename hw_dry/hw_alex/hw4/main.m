

coins = imread('coins.png');
SE = strel('disk',1,4);
coins_eroded = imerode(coins,SE);

coins_contours = coins - coins_eroded;
imshow(coins_contours)

circles = imread('some_circles.png');
% find centers
[centers,radii] = imfindcircles(coins,[20 50]);

