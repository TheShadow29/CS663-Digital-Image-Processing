function [out_img] = myPatchBasedFiltering(inp_img, sigma_space, sigma_range, window_around_pixel, window_around_P)
    tic;
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
    
    for i = mid+1:mid+m
        for j = mid+1:n+mid
            intensities = getNeighbourVector(padded_img,i,j,window_around_pixel, window_around_P);
            
            [m3,n3] = size(intensities);
            I_p = (intensities{(m3+1)/2, (n3+1)/2});
            
            [m5, n5] = size(I_p);
%             new_int = cellfun(@minus, intensities, I_p);
            for k=1:m3*n3
                [m4, n4] = size(intensities{k});
                if (n5 ~= n4 || m5 ~= m4)
                    intensities{k} = padarray(intensities{k},[abs(m5 - m4), abs(n5 - n4)], 'pre');
                end
                intensities{k} = intensities{k} - I_p;
            end
            
            new_int = cellfun(@norm, intensities);
            intensities_g = normpdf(new_int, 0, sigma_range);
            
            W_p = intensities_g.*distances_g;
            for k=1:m3*n3
                wp_int = W_p * intensities{k};
            end
            WI_p = sum(wp_int);
            
            out_img(i-mid, j-mid) = sum(WI_p(:))/sum(W_p(:));
        end
    end
    figure; imshow(inp_img, [min(inp_img(:)), max(inp_img(:))]);
    figure; imshow(noisy_img, [min(noisy_img(:)), max(noisy_img(:))]);
    figure; imshow(out_img, [min(out_img(:)), max(out_img(:))]);
    toc;
end
