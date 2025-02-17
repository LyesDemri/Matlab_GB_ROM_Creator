clear;clc;close all;

filename = 'Photo.jpg';

completeI = rgb2gray(imread(filename));

completeI = imresize(completeI,[144,160]);

completeI = double(completeI);

%Quantization
completeI = floor(completeI/64);
completeI = 3-completeI;
imshow(uint8(255-completeI*64))

m = 1;
t = 1;
tile_map_index = 1;
for l = 1:8:144
    for c = 1:8:160
        tile{t} = completeI(l:l+7,c:c+7);
        tile_exists = false;
        for i = 1:t-1
            if prod(prod(tile{i} == tile{t}))
                tile_map(tile_map_index) = i-1;
                tile_map_index = tile_map_index + 1;
                tile_exists = true;
            end
        end
        if ~tile_exists
            %we only get here if tile is first of its kind
            bits = de2bi(reshape(tile{t}',[numel(tile{t}),1]),2,'left-msb');
            bits1 = bits(:,1)';
            bits2 = bits(:,2)';
            for k = 1:8:64
                bytes{m} = dec2hex(bi2de(bits1(k:k+7)),2);
                bytes{m+1} = dec2hex(bi2de(bits2(k:k+7)),2);
                m = m+2;
            end
            tile_map(tile_map_index) = t-1;
            tile_map_index = tile_map_index + 1;
            t = t+1;
        end
    end
end

disp([num2str(length(bytes)) ' bytes used (0x' dec2hex(length(bytes)) ')']);
save('photo_deduplicated.mat','bytes')

tile_map = dec2hex(tile_map);
save('photo_map_deduplicated.mat','tile_map')

disp('done')