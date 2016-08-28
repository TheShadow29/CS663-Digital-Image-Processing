function [ outputImage ] = patch_based( sigma_patch, windowSizeSmall, windowSizeLarge )
load('barbara.mat');
inputImage = imageOrig;
outputImage = zeros(size(inputImage));

%compute size of image
[rows columns] = size(inputImage);
 
% add noise to the image
std_dev = 0.05*max(inputImage(:));
noise = std_dev*randn(size(inputImage));
img_noise = inputImage + noise;
img_noise = single(img_noise);
img_noise  =round(img_noise);
%figure
%imshow(img_noise, [min(img_noise(:)), max(img_noise(:))]);

% img_noise is the corrupted image

%computing the distance gaussian which would be same for all windows
%mid = (windowSize -1)/2;
%index = [-mid:mid];
%index = index.^2;
%dest_mat = repmat(index, [windowSize,1]);
%distances = dest_mat + dest_mat';
%distances = sqrt(distances);
%distances_g = normpdf(distances, 0 , sigma_space);
mid_small = (windowSizeSmall -1)/2;
mid_large = (windowSizeLarge - 1)/2;
mid = mid_small + mid_large;

%create a padded image for convolution
padded_img = zeros([rows+windowSizeSmall+windowSizeLarge, columns+windowSizeSmall+windowSizeLarge]);
padded_img(mid+1:mid+rows, mid+1:mid+columns) = img_noise;
tic 
for i = mid+1:mid+rows
    for j = mid+1:columns+mid
        I_p = padded_img(i,j);
        intensities = getNeighbourhoodWindow(padded_img,i,j,windowSizeLarge);
        patches = getNeighbourhoodWindow(padded_img,i,j,windowSizeLarge+windowSizeSmall-1);
        %intensities_g = normpdf((intensities-I_p), 0, sigma_range);
        weights = patch_weights(patches, windowSizeSmall, windowSizeLarge, sigma_patch);
        %disp(weights);
        %W_p = intensities_g.*distances_g;
        %WI_p = W_p.*intensities;
        new_intensities = weights.*intensities;
        outputImage(i-mid, j-mid) = sum(new_intensities(:));
    end
end
 toc;
figure
imshow(outputImage, [min(outputImage(:)), max(outputImage(:))]);
        
        

end

