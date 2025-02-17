clear;clc;close all;

map = [2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2;
       2 0 0 0 0 0 0 0 2 0 2 0 2 0 2 0 2 0 0 0;
       2 0 2 2 2 2 2 0 2 0 2 0 2 0 0 0 2 0 0 2;
       2 0 2 0 2 0 2 0 2 0 2 0 0 2 0 2 2 2 0 2;
       2 0 2 0 2 0 0 0 2 0 2 0 2 0 0 0 2 0 0 2;
       2 0 2 0 2 0 2 2 2 0 0 0 2 0 2 0 2 0 2 2;
       2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 2 0 0 2;
       2 0 2 0 0 0 2 0 2 0 2 0 0 0 2 0 2 2 0 2;
       2 0 2 2 2 2 2 0 0 0 2 0 2 0 2 0 0 0 0 2;
       2 0 2 0 2 0 0 0 2 2 2 2 2 2 2 2 2 2 2 2;
       2 0 2 0 0 0 2 0 0 2 0 0 0 0 0 2 2 2 0 2;
       2 0 2 2 2 0 2 0 2 2 0 2 2 2 0 0 0 2 0 2;
       2 0 2 0 2 0 2 0 0 2 0 0 0 2 0 2 0 0 0 2;
       2 0 0 0 2 0 2 2 2 2 2 2 0 2 0 2 2 2 2 2;
       2 0 2 0 2 0 0 0 0 0 0 2 0 2 0 0 0 0 0 2;
       2 0 2 0 2 2 2 2 0 2 0 2 0 2 2 2 2 2 0 2;
       2 0 2 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 2;
       2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];

map2 = fliplr(map);
map2(9,end) = 0;

map3 = zeros(18,20);
map3(1,:) = 2; map3(1,10) = 0;
map3(end,:) = 2; map3(end,10) = 0;
map3(:,1) = 2; map3(9,1) = 0;
map3(:,end) = 2; map3(9,end) = 0;

%imshow(imresize(uint8(map*255/max(max(map))),20,'nearest'));
bytes = reshape(map3',1,numel(map3));
%bytes = [bytes reshape(map2',1,numel(map2))];

for i = 1:24
    bytes = [bytes reshape(map3',1,numel(map3))];
end

bytes = [bytes reshape(map',1,numel(map))];

bytes = dec2hex(bytes);
save('map.mat','bytes');
 
disp(['Map created successfully']);