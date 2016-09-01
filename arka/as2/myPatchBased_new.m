function [out_img] = myPatchBased_new(inp_img, sigma_space, sigma_range, window_around_pixel, window_around_P)
    
    tic;
    count = 0;
    out_img = zeros(size(inp_img));

    %compute size of image
    [m, n] = size(inp_img);

    % add noise to the image
    std_dev = 0.05*max(inp_img(:));
    noise = std_dev*randn(size(inp_img));
    noisy_img = inp_img + noise;
    noisy_img = single(noisy_img);
    
    %computing the distance gaussian which would be same for all windows
    mid = (window_around_P -1)/2;
    index = -mid:mid;
    index = index.^2;
    dest_mat = repmat(index, [window_around_P,1]);
    distances = dest_mat + dest_mat';
    distances = sqrt(distances);
    distances_g = normpdf(distances, 0 , sigma_space);
    
    %create a padded image for convolution
    padded_img = zeros([m+window_around_pixel + window_around_P, n+window_around_pixel+window_around_P]);
    padded_img(mid+1:mid+m, mid+1:mid+n) = noisy_img;
%     [m1, n1] = size(padded_img);
    
    for i = mid+1:mid+m
        count = count +1;
        for j = mid+1:n+mid
%             central_window_indices = getNeighborWindowIndices(padded_img, i, j, window_around_P)
            
            patch = getNeighbourhoodWindow(padded_img, i, j, window_around_P + window_around_pixel - 1);
            [patch_weight] = getPatch_weights(patch,i,j,window_around_pixel, window_around_P, sigma_range);
            
            W_p = patch_weight.*distances_g;
            patch1 = getNeighbourhoodWindow(padded_img,i,j,window_around_P);
            WpIp = W_p.*patch1;
            out_img(i-mid, j-mid) = sum(WpIp(:))/sum(W_p(:));         
        end
        disp(count);
        
    end
    figure; imshow(inp_img, [min(inp_img(:)), max(inp_img(:))]);
    figure; imshow(noisy_img, [min(noisy_img(:)), max(noisy_img(:))]);
    figure; imshow(out_img, [min(out_img(:)), max(out_img(:))]);
    toc;
end
