clear;clc;close all;

load('guilt machine_deduplicated.mat')
load('guilt machine_map_deduplicated.mat');

bytes = hex2dec(bytes);
tile_map = hex2dec(tile_map);

bytes1 = bytes(1:2:end);
bytes2 = bytes(2:2:end);

t = 1;
tiles = cell(1,length(bytes1)/8);
for k = 0:8:length(bytes1)-1
        bits1 = de2bi(bytes1(k+1:k+8)',8,'left-msb');
        bits2 = de2bi(bytes2(k+1:k+8)',8,'left-msb');
        bits1 = reshape(bits1,numel(bits1),1);
        bits2 = reshape(bits2,numel(bits2),1);
        bits = [bits1,bits2];
        pixels = bi2de(bits);
        pixels = reshape(pixels,8,8);
        I = pixels*63;
        I = 255-I;
        tiles{t} = I;
        t = t+1;
end

t = 1;
for l=1:8:18*8
    for c = 1:8:20*8
        I(l:l+7,c:c+7) = tiles{tile_map(t)+1};
        t = t+1;
    end
end
imshow(uint8(I))

t = 1;
for l = 1:8:18*8
    line([0,size(I,2)],[l-1,l-1],'Color','red');
    for c = 1:8:20*8
        text(c,l+3,dec2hex(tile_map(t),2),'Color','red');
        t = t+1;
        line([c-1,c-1],[0,size(I,1)],'Color','red');
    end
end
