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
