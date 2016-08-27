function [intensity_vector] = getNeighbourVector(image, i ,j, WindowSize)
    area = size(image);
    length = (WindowSize - 1)/2;
    ind_i = max(1,i - length) : min(area(1),i + length);
    ind_j = max(1,j - length) : min(area(2),j + length);
    [~,n1] = size(ind_i);
    [~,n2] = size(ind_j);
    
    i1 = 1;
    for k=ind_i
        j1 = 1;
        for l=ind_j
            intensity_vector{i1,j1} = image( max(1,k - length) : min(area(1),k + length) , max(1,l - length) : min(area(2),l + length) );
            j1 = j1 +1;
        end
        i1 = i1 + 1;
    end

end