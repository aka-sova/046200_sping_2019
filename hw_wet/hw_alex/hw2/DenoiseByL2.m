function [Xout, Err1, Err2] = DenoiseByL2 (Y,X, numIter, lambda)

% denoise the image. arguments:

% Y - image with noise
% X - original image
% numiter - iterations
% lambda - regularisation


% define the kernel of the Laplasian
lapl_kernel = [ 0 1 0; 1 -4 1; 0 1 0];

for iter_num=1:numIter 

    
    % find the step size







end




end

