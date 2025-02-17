clear;clc;close all;

M = {};
N_maps = 25;
for i=1:N_maps
    M = double(imread(['maps/map' num2str(i) '.bmp']));
    M = 255-M(:,:,1);
    M = M*2/255;
    map{i} = M;
end

bytes = [];
for i = 1:N_maps
    bytes = [bytes reshape(map{i}',1,numel(map{i}))];
end

bytes = dec2hex(bytes);
save('map.mat','bytes');
 
disp(['Map created successfully']);