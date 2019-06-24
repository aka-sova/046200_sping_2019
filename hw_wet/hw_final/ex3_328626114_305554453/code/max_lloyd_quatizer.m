function [dataout, distortion, QL , eps] = max_lloyd_quatizer(data, levels, meps, initialization)

    % quantizer:
    
    % data - input
    % levels - number of levels to represent the data
    % meps - minimal improvement level. Stop if the improvement is lower
    
    
    % dataout - quantized data
    % distorion - vector of distortion at each step
    % QL - [levelsX3] matrix with the dictionary vectors - representative
    % levels
    
    
    max_iter_num = 1e6; % avoid infinite loop
    im_length = size(data,1)*size(data,2);
    
    
    % (1) Initialize random representative levels, 
    %     but of the colors present in the image
    
    if initialization == 1
        
        rand_idxs = round(rand(levels, 1)*(size(data,1)*size(data,2)));
        [i,j] = ind2sub(size(data),rand_idxs);

        % dumb way..
        for a=1:size(i)
            QL(a,:) = data(i(a),j(a),:);
        end

        QL = double(QL);
    
    else 
        levels = 9; % to ensure
        QL = round(255.*[0.9,0,0;...
            0,0.9,0;...
            0,0,0.9;...
            0.6,0,0.6;...
            0.7,0.7,0;...
            0,0.8,0.8;...
            0,0,0;...
            1,1,1;...
            0.5,0.5,0.5]);
        
        
    end

    % reshape the data block and the QL block.
    % they need to be same size
    
    
    data = double(data);
    data_vector = reshape(data,im_length,1,3);
    data_block = repmat(data_vector,[1,levels,1]);
    
    QL_vec = reshape(QL, size(QL(:)));
    QL_vec = reshape(QL_vec, 1, levels, 3);
    
    QL_block = repmat(QL_vec,[im_length,1,1]);

    % (2) initialize the loop
    iter = 1;
    eps = meps+1;
    distortion = 1; % putting it an some initial low value
    
    while eps(end) > meps && iter < max_iter_num
        
        % (1) calculate the differences
        diff = (data_block - QL_block).^2;
        diff_sum = sum(diff, 3);
        
        % find the closest representation
        [min_dist, min_idx] = min(diff_sum,[],2);
        
        % update the representative levels, using the center of a mass of
        % all the points
        
        for level=1:levels
           
           
           indexes = min_idx==level;
           new_ql = round(mean(data_vector(indexes, 1, :)));
           QL(level,:) = reshape(new_ql,1,3);
        end
        
        % recalculate the QL block
        
        QL_vec = reshape(QL, size(QL(:)));
        QL_vec = reshape(QL_vec, 1, levels, 3);

        QL_block = repmat(QL_vec,[im_length,1,1]);
    
    
        
        % calculate the new image - for each pixel
        

        cur_data_out = QL(min_idx,:);
        cur_data_out = reshape(cur_data_out, size(data));
        
        % calculate the distortion 
        SE = sum((data-cur_data_out).^2,3);
        MSE = mean(SE(:));
        distortion(end+1) = MSE;
        
        % calculate the epsilon
        
        eps(end+1) = abs(distortion(end)-distortion(end-1))/distortion(end);
        
        if mod(iter, 100) == 0
           fprintf('Iter: %2.0f', iter); 
        end
        
    end
    
    dataout = uint8(cur_data_out);
end








