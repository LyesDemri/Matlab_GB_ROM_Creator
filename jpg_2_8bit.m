clear;clc;close all;

filename = 'Photo.jpg';

completeI = rgb2gray(imread(filename));

completeI = imresize(completeI,[144,160]);

completeI = double(completeI);

%Quantization
completeI = floor(completeI/64);
completeI = 3-completeI;
imshow(uint8(255-completeI*64))

m=1;
for l = 1:8:144
    for c = 1:8:160
        tile = completeI(l:l+7,c:c+7);
        bits = de2bi(reshape(tile',[numel(tile),1]),2,'left-msb');
        bits1 = bits(:,1)';
        bits2 = bits(:,2)';
        for k = 1:8:64
            bytes{m} = dec2hex(bi2de(bits1(k:k+7)),2);
            bytes{m+1} = dec2hex(bi2de(bits2(k:k+7)),2);
            m = m+2;
        end
    end
end

disp([num2str(length(bytes)) ' bytes used (0x' dec2hex(length(bytes)) ')']);
save('photo.mat','bytes')


tile_map = dec2hex([0:255, 0:(length(bytes)-255-1)]);

save('photo_map.mat','tile_map')

disp('done')