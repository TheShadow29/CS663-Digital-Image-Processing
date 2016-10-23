function [ img ] = filterImplement( D, inp_img )
[h w] = size(inp_img);
padded_img = zeros(2*size(inp_img));
padded_img((h/2)+1:(3*h/2) ,(w/2)+1:(3*w/2) )  = inp_img; 
fim2 = fftshift(fft2(padded_img));
absfim2 = log(abs(fim2)+1);
figure; imagesc(absfim2, [-1 18]);
colormap(jet); colorbar;
filter = zeros(512,512);
for i = 129:384
    for j = 129:384
          %  filter(i,j) = exp(-((i - 256)^2 + (j- 256)^2)/(2*D^2));
       if (i -256)^2 + (j-256)^2 <= D^2
            filter(i,j) =1 ;
       end
    end
end
%filter = ones(512, 512);
%filter(272:282, 262:272) =0;
%filter(232:242, 242:252) = 0;
%filter = logical(filter);
%figure ; imshow(filter);
figure;imagesc((filter));
absfil = absfim2.*filter;
figure; imagesc(absfil , [-1 18]);
colormap(jet); colorbar;

img = (ifft2(ifftshift(fim2.*filter)));
img = img(129:384, 129:384);
figure;imshow(uint8(abs(img)));


end

