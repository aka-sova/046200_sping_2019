function [mult_matrix] = create_row_to_col_order_matrix(row_ordered_matrix)

    % create a matrix which will multiply the row ordered image to
    % create column ordered image
    
    image_size = sqrt(numel(row_ordered_matrix));
    mult_matrix = zeros(image_size^2, image_size^2);
    
    row_index=1;
    column_index=1;
    
    
    for i=1:(image_size^2)
        % for each pixel
        mult_matrix(row_index, column_index) = 1;
        row_index = row_index+1;
        column_index = column_index+image_size;
        
        if (column_index>image_size^2 && mod(column_index,image_size^2) > 0 ) 
            column_index = mod(column_index,image_size^2)+1;
        end 
    end

end

