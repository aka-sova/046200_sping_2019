function max_values = find_max_exact_values(image,threshold)

    max_values = [];

    for row=1:size(image,1)
        for col=1:size(image,2)
            if image(row,col) > threshold
                max_values(end+1, 1) = row;
                max_values(end, 2) = col;
            end
        end
    end

end

