function [ outputImage ] = myBilinearInterpolation( inputImage )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[M N] = size(inputImage);
%rows = 3*M - 2;
%columns = 2*N -1;
outputImage = zeros(3*M-2, 2*N-1);
outputImage(3*[1:M]-2,2*[1:N]-1) = inputImage([1:M],[1:N]);
outputImage(3*[1:M]-2,2*[1:N-1]) = (outputImage(3*[1:M]-2,2*[1:N-1]-1) + outputImage(3*[1:M]-2,2*[1:N-1]+1))*0.5;
outputImage(3*[1:M-1],[1:2*N-1]) = (outputImage(3*[1:M-1]-2,[1:2*N-1]) + 2*outputImage(3*[1:M-1]+1,[1:2*N-1]))/3;
outputImage(3*[1:M-1]-1,[1:2*N-1]) = (2*outputImage(3*[1:M-1]-2,[1:2*N-1]) + outputImage(3*[1:M-1]+1,[1:2*N-1]))/3;
outputImage = uint8(outputImage);

end

