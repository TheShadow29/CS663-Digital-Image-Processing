function [ outputImage ] = myUnsharpMasking(  )
 load('lionCrop.mat');
 inputImage = imageOrig;
 h = fspecial('log', 9, 0.3);
 out = imfilter(inputImage, h);
 in_new = inputImage - min(min(inputImage));
 in_new = in_new/max(max(in_new));
 out_new = out - min(min(out));
 out_new = out_new/max(max(out_new));
 outputImage = out_new;
 figure
 imshow(in_new);
 figure
 imshow(out_new);
 
 


end

