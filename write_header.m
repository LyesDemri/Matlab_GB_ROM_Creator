function write_header()
global rom;
global PC;
%Nintendo logo
nintendo_logo_bytes = 'CE ED 66 66 CC 0D 00 0B 03 73 00 83 00 0C 00 0D 00 08 11 1F 88 89 00 0E DC CC 6E E6 DD DD D9 99 BB BB 67 63 6E 0E EC CC DD DC 99 9F BB B9 33 3E';
nintendo_logo_bytes = strsplit(nintendo_logo_bytes,' ');
for i = 1:length(nintendo_logo_bytes)
    rom(PC+1) = hex2dec(nintendo_logo_bytes{i});
    PC = PC+1;
end

%Title
title = 'Infinity Maze';
title = double(title);
title(length(title)+1:16) = 0;

rom(PC+1:PC+16) = title;PC = PC+16;

%Manufacturer code
%Not implemented

%CGB Flag: I just need to set it to 0. Already done at "title" part

%New licensee code:
rom(PC+1) = 0;PC = PC+1;
rom(PC+1) = 0;PC = PC+1;

%SGB Flag: don't need it. set it to 0.
rom(PC+1) = 0;PC = PC+1;

%Cartridge type: I'll just use ROM ONLY
rom(PC+1) = 0;PC = PC+1;

%ROM size: use a 32 KiB ROM size
rom(PC+1) = 0;PC = PC+1;

%RAM size: No RAM on the cartridge
rom(PC+1) = 0; PC = PC+1;

%Destination code: Japan & overseas
rom(PC+1) = 0;PC = PC+1;

%Old licensee code: None
rom(PC+1) = 0; PC = PC+1;

%Mask ROM version number
rom(PC+1) = 0;PC = PC+1;

%Header checksum:
checksum = 0;
for a = (hex2dec('0134')+1):(hex2dec('014C')+1)
    checksum = bin2dec(dec2bin(checksum - double(rom(a)) - 1,8));
end
rom(PC+1) = checksum;PC = PC+1;