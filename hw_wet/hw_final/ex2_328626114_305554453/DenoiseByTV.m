function [Xout, Err1, Err2] = DenoiseByTV (Y, X, numIter, lambda)


    % denoise the image. arguments:

    % Y - image with noise
    % X - original image
    % numiter - iterations
    % lambda - regularisation

    
    % conv2, reshape, imnoise, meshgrid, semilogy, sparse, imgradientxy, divergence.



    % initialize 
    X_k = Y;

    Err1 = [];
    Err2 = [];

    fig1 = figure();
    subplot_num = floor(numIter/50);

    e_0 = 1e-6;
    mu_k = 100*e_0;

    for iter_num=1:numIter 

        % find the required parameters    
        U_comp_1 = 2*(Y-X_k);
        
        % find gradients
        [Gx, Gy] = imgradientxy(X_k);

        % normalize the gradients by their values
        grad_abs = Gx.^2 + Gy.^2;
        denominator = sqrt(grad_abs + e_0^2);

        U_comp_2 = divergence(Gx./denominator, Gy./denominator);

        U_k = U_comp_1 + lambda* U_comp_2;

        % err values

        % (X-Y)^T(X-Y) + lambda * (DX)^T(DX)

        err_1_comp_1 = ((X_k(:)-Y(:)).'*(X_k(:)-Y(:)));

        % find total variation
        TV = sum(sqrt(Gx(:).^2 + Gy(:).^2));
        err_1_comp_2 = TV;

        Err1(iter_num) = err_1_comp_1 + lambda *err_1_comp_2;

        % (Xk-X)^T(Xk-X)
        Err2(iter_num) = ((X_k(:)-X(:)).'*(X_k(:)-X(:)));


        % step forward
        X_k = X_k + (mu_k/2)*U_k;


        % display the resulting image every 10 iterations
        if ~mod(iter_num,50)
            fig1;
            subplot(1, subplot_num, floor(iter_num/50));
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
    title('Error values (TV)');


    Xout = X_k;




end

