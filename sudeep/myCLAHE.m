function [ outputImage ] = myCLAHE( inputImage, h, N )

[m n] = size(inputImage);

tic
for i = 1:m
    for j = 1:n 
        tempImg = getNeighbourhoodWindow(inputImage, i, j, N);
        tempOut = myCLHE(tempImg+1, h);
        index = [min(i,(N+1)/2), min(j,(N+1)/2)];
        inputImage(i,j) = tempOut(index(1), index(2));
    end
end
outputImage = inputImage;
toc

end

