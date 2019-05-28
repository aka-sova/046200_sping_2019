function [Xout, Err1, Err2] = DenoiseByL2 (Y,X, numIter, lambda)

    % denoise the image. arguments:

    % Y - image with noise
    % X - original image
    % numiter - iterations
    % lambda - regularisation


    % conv2, reshape, imnoise, meshgrid, semilogy, sparse, imgradientxy, divergence.

    % define the kernel of the Laplasian
    D_kernel = [ 0 1 0; 1 -4 1; 0 1 0];

    % initialize 
    D_filt = eye(3) + lambda*(D_kernel'*D_kernel);
    %D_filt = eye(5) + lambda*conv2(D_kernel',D_kernel);
    X_k = Y;

    Err1 = [];
    Err2 = [];

    fig1 = figure();
    subplot_num = floor(numIter/10);

    for iter_num=1:numIter 

        % find the required parameters    
        im_filtered = conv2(X_k, D_filt, 'same');
        G_k = im_filtered - Y;

        % err values

        % (X-Y)^T(X-Y) + lambda * (DX)^T(DX)

        err_1_comp_1 = ((X_k(:)-Y(:))'*(X_k(:)-Y(:)));
        err_1_comp_2 = im_filtered(:)'*im_filtered(:);

        Err1(iter_num) = err_1_comp_1 + lambda *err_1_comp_2;

        % (Xk-X)^T(Xk-X)
        Err2(iter_num) = ((X_k(:)-X(:))'*(X_k(:)-X(:)));

        % step size
        G_filt = conv2(G_k, D_filt,'same');
        mu_k = (G_k(:)'*G_k(:))./(G_k(:)'*G_filt(:));


        % step forward
        X_k = X_k - mu_k*G_k;


        % display the resulting image every 10 iterations
        if ~mod(iter_num,10)
            fig1;
            subplot(1, subplot_num, floor(iter_num/10));
            imshow(X_k);
            title_head = sprintf('%s iterations', num2str(iter_num));
            title(title_head);
        end
    end

    fig = figure();
    semilogy(Err1);
    grid;
    xlabel('Iterations');
    ylabel('Error value');
    title('Error 1 value');


    fig = figure();
    semilogy(Err2);
    grid
    xlabel('Iterations');
    ylabel('Error value');
    title('Error 2 value');

    Xout = X_k;


end














% %% helpful functions
% function[Xout, Err1, Err2] = DenoiseByL2(Y, X, numIter, lambda)
% % laplacian kernel
% D = [ 0 -1 0;...
%      -1 4 -1;...
%       0 -1 0]; 
% 
% %pre-process
% Y = im2double(Y);
% X = im2double(X);
% 
% Err1 = zeros(numIter,1);
% Err2 = zeros(numIter,1);
% 
% I = eye(3); 
% 
% filter = I+lambda*(D.'*D);
% x_k = Y(:);
% 
% figure('Name','Denoise by L2')
% for i = 1:numIter
%     temp0 = conv2(x_k,D,'same');
%     Err1(i) = (x_k(:)-Y(:))'*(x_k(:)-Y(:))+lambda*(temp0(:)'*temp0(:));
%     Err2(i) = (x_k(:)-X(:))'*(x_k(:)-X(:));
%     
%     temp1 = conv2(x_k,filter,'same');
%     G = (temp1(:)-Y(:)); 
%     temp2 = conv2(G,filter,'same');
%     mu = (G(:)'*G(:))./(G(:).'*temp2(:));
%     
%     x_kp1 = x_k(:) - mu*G(:);
%     x_k = x_kp1;
%     if ~mod(i,10)
%         subplot(round(numIter/50),5,i/10)
%         imshow(reshape(x_kp1,size(X)),[]);
%         title(sprintf('iteration #%d',i));
%     end
% end
% 
% Xout = reshape(x_kp1,size(X));
% end
