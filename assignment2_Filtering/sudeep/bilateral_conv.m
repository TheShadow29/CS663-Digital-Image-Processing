function [ outputImage ] = bilateral_conv( sigma_space, sigma_range, windowSize )
load('barbara.mat');
inputImage = imageOrig;
outputImage = zeros(size(inputImage));

%compute size of image
[rows columns] = size(inputImage);
disp([rows columns]);
 
% add noise to the image
std_dev = 0.05*max(inputImage(:));
noise = std_dev*randn(size(inputImage));
img_noise = inputImage + noise;
img_noise = img_noise - min(img_noise(:));
img_noise = uint8(img_noise);
max_intensity = max(img_noise(:));
figure
imshow(img_noise, [min(img_noise(:)), max(img_noise(:))]);

% img_noise is the corrupted image

%computing the distance gaussian which would be same for all windows
mid = (windowSize -1)/2;
index = [-mid:mid];
index = index.^2;
dest_mat = repmat(index, [windowSize,1]);
distances = dest_mat + dest_mat';
distances = sqrt(distances);
distances_g = normpdf(distances, 0 , sigma_space);

%create a padded image for convolution
%padded_img = zeros([rows+windowSize, columns+windowSize]);
%padded_img(mid+1:mid+rows, mid+1:mid+columns) = img_noise;

%make the 3d matrix
base_mat = zeros([512 512 125]);
disp(size(base_mat));
weight_mat = zeros([512 512 125]);
for i = 1:max_intensity+1
    logical = (img_noise == i);
    
    base_mat(:,:,i) = uint8(logical)*i;
    weight_mat(:,:,i) = uint8(logical);
end

%make the conv vector
z = [-122:122];
intensity_g = normpdf(z, 0, sigma_range);
 
%make the conv matrix
conv_matrix_base = repmat(distances_g, [1,1,length(intensity_g)]);
for j = 1:length(intensity_g)
    conv_matrix(:,:,j) = conv_matrix_base(:,:,j)*intensity_g(j);
end
    

%for i = mid+1:mid+rows
%    for j = mid+1:columns+mid
%        I_p = padded_img(i,j);
%        intensities = getNeighbourhoodWindow(padded_img,i,j,windowSize);
%        intensities_g = normpdf((intensities-I_p), 0, sigma_range);
%        W_p = intensities_g.*distances_g;
%        WI_p = W_p.*intensities;
%        outputImage(i-mid, j-mid) = sum(WI_p(:))/sum(W_p(:));
%    end
%end
WI_mat = convn(base_mat, conv_matrix, 'same');
W_mat = convn(weight_mat, conv_matrix, 'same');
WI = sum(WI_mat, 3);
W = sum(W_mat,3);
outputImage = uint8(WI./W);
figure
imshow(outputImage, [min(outputImage(:)), max(outputImage(:))]);
        
        

end

