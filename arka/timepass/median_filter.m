function [out_img] = median_filter(inp_img, neighborhood)
tic;
    [m,n] = size(inp_img);
%     std_dev = 0.05*max(inp_img(:));
%     noise = std_dev*randn(size(inp_img));
%     noisy_img = inp_img + noise;
%     noisy_img = single(noisy_img);
    noisy_img = imnoise(inp_img, 'salt & pepper');
    out_img = zeros(m,n);
    for i=1:m
        for j=1:n
            neighbor = getNeighbourhoodWindow(noisy_img, i,j, neighborhood);
            out_img(i,j) = median(neighbor(:));
        end
    end
    figure; imshow(noisy_img, [min(noisy_img(:)), max(noisy_img(:))]);
    figure; imshow(out_img, [min(out_img(:)), max(out_img(:))]);
    toc;
end