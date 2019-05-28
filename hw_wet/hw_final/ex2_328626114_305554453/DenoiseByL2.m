function [Xout, Err1, Err2] = DenoiseByL2 (Y,X, numIter, lambda)

    % denoise the image. arguments:

    % Y - image with noise
    % X - original image
    % numiter - iterations
    % lambda - regularisation


    % conv2, reshape, imnoise, meshgrid, semilogy, sparse, imgradientxy, divergence.

    % define the kernel of the Laplasian
    D_kernel = [ 0 1 0; 1 -4 1; 0 1 0];


    % D_filt = eye(3) + lambda*(D_kernel'*D_kernel);
    % D_filt = eye(5) + lambda*conv2(D_kernel',D_kernel);

    % find the convolution matrix
    D_matrix = convmtx2(D_kernel,size(Y));

    
    % initialize 
    X_k = Y;

    Err1 = [];
    Err2 = [];

    fig1 = figure();
    subplot_num = floor(numIter/10);

    for iter_num=1:numIter 

        % find the required parameters    
        G_k = (X_k(:) + lambda*(D_matrix.'*D_matrix*X_k(:))) - Y(:);

        % err values

        % (X-Y)^T(X-Y) + lambda * (DX)^T(DX)

        err_1_comp_1 = ((X_k(:)-Y(:)).'*(X_k(:)-Y(:)));
        err_1_comp_2 = (D_matrix*X_k(:)).'*(D_matrix*X_k(:));

        Err1(iter_num) = err_1_comp_1 + lambda *err_1_comp_2;

        % (Xk-X)^T(Xk-X)
        Err2(iter_num) = ((X_k(:)-X(:)).'*(X_k(:)-X(:)));

        % step size
        numer = G_k.'*G_k;
        G_k_filt = G_k(:) + lambda*(D_matrix.'*D_matrix*G_k(:));
        denom = G_k(:).'*G_k_filt;

        mu_k = numer/denom;


        % step forward
        X_k = X_k - mu_k*reshape(G_k,size(Y));


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
    hold on;
    semilogy(Err2);
    legend('Err1','Err2');
    grid;
    xlabel('Iterations');
    ylabel('Error value (log)');
    title('Error values (L2)');

    Xout = X_k;


end





% function [Xout, Err1, Err2] = DenoiseByL2(Y, X, numIter, lambda)
% Err1 = zeros(numIter,1);
% Err2 = zeros(numIter,1);
% Y = double(Y);
% Xk = double(Y);
% X = double(X);
% 
% % Define Laplacian kernel:
% D_conv = [0 1 0;
%         1 -4 1;
%         0 1 0];
% %D = D_conv;
% %D2 = D.'*D;
% [m,n] = size(X);
% D = sparse(convmtx2(D_conv, m, n));
% %D = convmtx2(D_conv, m, n);
% % Define other matrices:
% 
% for k = 1:numIter
% % Column stacking the images:
% Y_cs = Y(:);
% X_cs = X(:);
% Xk_cs = Xk(:);
% % Column stacking the processed image:
% % Defines G matrix:
% G_cs = Xk_cs + lambda*D.'*D*Xk_cs  - Y_cs;
% G2_cs = G_cs + lambda*D.'*D*G_cs;
% 
%  % Defines mu parameter:
% mu = (G_cs.'*G_cs)/(G_cs.'*G2_cs);
% 
% % Calculate the output image:
% Xout_cs = Xk_cs - mu*(G_cs);
% Xout = reshape(Xout_cs,size(X));
% 
% % Calculate the error vectors:
% DX_cs = D*Xk_cs;
% Err1(k) = (Xk_cs-Y_cs).'*(Xk_cs-Y_cs)+lambda*(DX_cs.'*DX_cs);
% Err2(k)= (Xk_cs-X_cs).'*(Xk_cs-X_cs);
% % Calculate the error vectors:
% 
% if (mod(k,10) == 0)
%     figure;
%     imshow(uint8(Xout));
%     title(['L2 Image after ',num2str(k),' iterations']);
% end
% 
% Xk = Xout;
% end 
% 
% end








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
