function compute_global_checksum()
global rom;
global PC;

checksum = 0;
for i = 1:length(rom)
    %you don't use these 2 addresses for the calculation
    if i == (hex2dec('014E')+1) || i == (hex2dec('014F')+1)
        continue;
    end
    %you can't just add the numbers in decimal, you must make sure that
    %you're accounting for the fact you're only adding on 16 bits and not
    %using the carry.
    checksum = dec2bin(checksum + double(rom(i)),16);
    checksum = fliplr(checksum);
    checksum = fliplr(checksum(1:16));
    checksum = bin2dec(checksum);
end

%you also need to make sure to separate the 16 high bits from the 16 low
%bits
checksum = dec2bin(checksum,16);
checksumH = bin2dec(checksum(1:8));
checksumL = bin2dec(checksum(9:16));
rom(hex2dec('014E')+1) = checksumH;
rom(hex2dec('014F')+1) = checksumL;