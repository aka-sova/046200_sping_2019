% function [code,dict,avglen] = huffcoding(im)
% 
%     % Huffman coding  - ONLY WORKS FOR UINT8 IMAGES
%     
%     % code - huffman code
%     % dictionary
%     % avglen - average data rate
%     
%     % RS
%     im_rs = reshape(im, size(im,1)*size(im,2),1);
%     
%     % 
%     im_hist = imhist(im_rs);
%     unique_vals = unique(im_rs);
%     
%     im_hist_unique = im_hist(unique_vals+1);
%     p = im_hist_unique/length(im_rs);
%     
%     [dict,avglen] = huffmandict(unique_vals,p);
%     
%     % turn the image into code
%     
%     code = huffmanenco(im_rs, dict);
%     
%     % verify that the bits amount is as predicted:
%     
%     avg_bit_rate_check = length(code) / length(im_rs);
%     
%     if (avg_bit_rate_check == avglen)
%        fprintf('Huffman encoding is successful\n'); 
%     end
%     
% end




function [code,dict,avglen] = huffcoding(im)

    % Huffman coding - WORKS FOR ANY KIND OF DATA
    
    % code - huffman code
    % dictionary
    % avglen - average data rate
    
    % RS
    im = double(im);
    im_rs = reshape(im, size(im,1)*size(im,2),1);
    
    % find the exact range
    
    bin_num = max(im_rs(:)) - min(im_rs(:));
    
    im_hist = hist(im_rs, bin_num+1);
    unique_vals = unique(im_rs);
    
    im_hist_unique = im_hist(unique_vals(:)+1-min(im_rs(:)));
    p = im_hist_unique/length(im_rs);
    
    [dict,avglen] = huffmandict(unique_vals,p);
    
    % turn the image into code
    
    code = huffmanenco(im_rs, dict);
    
    % verify that the bits amount is as predicted:
    
    avg_bit_rate_check = length(code) / length(im_rs);
    
    if (avg_bit_rate_check == avglen)
       fprintf('Huffman encoding is successful\n'); 
    end
    
end
