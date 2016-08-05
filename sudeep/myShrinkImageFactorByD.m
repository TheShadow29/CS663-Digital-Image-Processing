function [ outputImage ] = myShrinkImageFactorByD( inputImage, d )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[length breadth] = size(inputImage);
length_integer = floor(length/d);
breadth_integer = floor(breadth/d); 
rows = 1:length_integer;
rows = rows.*d;
columns = 1:breadth_integer;
columns = columns.*d;

outputImage = inputImage(rows,columns);


end

