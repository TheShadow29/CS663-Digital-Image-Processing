function [output] = readAllYale()
output = [];
for i = 1 : 39
    foldername = 'C:\Users\Sudeep\Desktop\Sudeep\Semester 5\CS 663\Assignment 4\CroppedYale\yaleB';
    if (i < 10)
        foldername = strcat(foldername, '0',num2str(i),'\');
    else if (i == 14)
            continue;
        else
            foldername = strcat(foldername,num2str(i),'\');
        end
    end
    srcFiles = dir(strcat(foldername,'*.pgm'));
        
    for j = 41:60
    %disp(filename);
    filename = strcat(foldername,srcFiles(j).name);
    X = imread(filename);
    X = double(X)/255;
    output = [output, X(:)];
    %figure, imshow(X);
    end 
end
    %sample = X(300:512 , 300:512);
    %if(size(X,3) == 1)
    %    X( x:x+199 , y:y+199 ) = m;
    %else
    %    X( x:x+199 , y:y+199 ,1 ) = m;
    %    X( x:x+199 , y:y+199 ,2 ) = m;
    %    X( x:x+199 , y:y+199 ,3 ) = m;
    %end;
    
   % output = myCLAHE(img, i/10, 101);
   % figure, imshow(output);
   % imwrite(output, strcat('C:\Users\Sudeep\Desktop\Sudeep\Semester 5\CS 663\CLAHE101\', num2str(i),'.png'), 'png'); 
end