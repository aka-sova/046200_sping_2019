function [output_image] = find_image_segment_min(image,small_image_size)

    % find the minimum in each segment of the size of the small image size
    % and apply this value to the whole segment
    
    rows = small_image_size(1);
    cols = small_image_size(2);
    
    x_seg_num = length(image(:,1))/rows;
    y_seg_num = length(image(:,2))/cols;
    
    output_image = uint8(ones(size(image)));
    
    for i = 1:x_seg_num 
        for j = 1:y_seg_num
        
            % 1. put segment into separate matrix
            segment = image(rows*(i-1)+1:rows*i,cols*(j-1)+1:cols*j);
            
            % 2. find the minimal value
            segment(:) = min(segment(:));
        
            % 3. put into output matrix
            output_image(rows*(i-1)+1:rows*i,cols*(j-1)+1:cols*j) = segment;
        
        end
    end
    

end

