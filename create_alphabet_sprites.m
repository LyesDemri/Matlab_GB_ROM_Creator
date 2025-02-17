clear;clc;close all;

for i = 1:26
    input_filename = ['Alphabet\Letter' char(i+64) '.bmp'];
    sprite_creator(input_filename);
end