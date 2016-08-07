function [ outputImage ] = myAHE( inputImage, N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m n] = size(inputImage);
%disp(m);disp(n);

tic
for i = 1:m
    for j = 1:n 
        tempImg = getNeighbourhoodWindow(inputImage, i, j, N);
        tempOut = myHE(tempImg+1);
        index = [min(i,(N+1)/2), min(j,(N+1)/2)];
        inputImage(i,j) = tempOut(index(1), index(2));
    end
end
outputImage = inputImage;
toc

end

