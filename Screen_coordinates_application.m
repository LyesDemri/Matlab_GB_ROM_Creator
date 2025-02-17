clear;clc;close all;



k=12288;
for l = 1:18
    for c = 1:20
        M(l,c) = k;
        k = k+1;
    end
end

for l = 1:18
    for c = 21:40
        M(l,c) = k;
        k = k+1;
    end
end

for l = 1:18
    for c = 41:60
        M(l,c) = k;
        k = k+1;
    end
end