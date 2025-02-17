clear;clc;close all;

lines{1} = double('THANKS FOR PLAYING')-double('A')+1;
lines{2} = double('L DEMRI')-double('A')+1;

%replace spaces by "26";
for i=1:length(lines)
    lines{i}(lines{i}==-32) = 0;
end

credits_map = zeros(18,20);
for i=1:length(lines)
    credits_map(i,1:length(lines{i})) = lines{i};
end

bytes = reshape(credits_map',1,numel(credits_map));
bytes = dec2hex(bytes);
save('credits_map.mat','bytes');

disp('credits map created!')