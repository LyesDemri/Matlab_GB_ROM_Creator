function sprite_creator(varargin)

input_filename = varargin{1};
if length(varargin) == 1
    output_filename = [input_filename(1:end-4) '.mat'];
elseif length(varargin) == 2
    output_filename = varargin{2};
end

I = imread(input_filename);
if size(I,3) == 3
    I = rgb2gray(I);
end

I = 255-I;
I1 = zeros(size(I));
I2 = zeros(size(I));
I1(I>0 & I<=128) = 1;
I1(I==255) = 1;
I2(I>128 & I<255) = 0;
I2(I==255) = 1;

bytes1 = dec2hex(bi2de(I1),2);
bytes2 = dec2hex(bi2de(I2),2);

for i=1:8
    bytes{2*i-1} = bytes1(i,:);
    bytes{2*i} = bytes2(i,:);
end

save(output_filename,'bytes')