function [pyrGaus, pyrLap] = pyrGen (image ,lvl_num, cur_lvl )


% build the Gaussian and Laplasian pyramids of specific depth
% using recursion


filt_kernel  =   fspecial('gaussian',5,1);



if (cur_lvl == lvl_num )
    % reached the top of pyramid
    pyrGaus{1} = image;
    pyrLap{1} = image;    
else 
    % filter and reduce the image size for each next level
    im_filtered =   imfilter(image, filt_kernel, 'symmetric');
    im_reduced = impyramid(im_filtered, 'reduce');
    
    % create the layers beneath
    [pyrGaus, pyrLap] = pyrGen(im_reduced, lvl_num, cur_lvl + 1);
    
    % create the current level
    pyrGaus{end+1} = image;
    
    im_restored = impyramid(im_reduced, 'expand');
    pyrLap{end+1} = image - im_restored;
end
    


end


