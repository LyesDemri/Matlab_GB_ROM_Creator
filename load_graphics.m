%graphics come after the subroutine section
disp(['Start of graphics: ' dec2hex(PC,4)])

load('happy_face_bytes.mat');
happy_face_address = dec2hex(PC,4);
disp(['happy face tile bytes start at: ' happy_face_address]);
rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
PC = PC + length(bytes);

load('Wall.mat');
wall_address = dec2hex(PC,4);
disp(['wall tile bytes start at: ' wall_address]);
rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
PC = PC + length(bytes);

load('sad_face_bytes.mat');
sad_face_address = dec2hex(PC,4);
disp(['sad face tile bytes start at: ' sad_face_address]);
rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
PC = PC + length(bytes);

%load('photo.mat');
load('photo_deduplicated.mat');
lyes_photo_tiles_address = dec2hex(PC,4);
disp(['photo tiles bytes start at: ' lyes_photo_tiles_address]);
rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
PC = PC + length(bytes);
offset_for_letter_tiles = length(bytes)/16;

letter_tiles_address = dec2hex(PC,4);
disp(['alphabet tiles start at: ' dec2hex(PC)]);
PC = PC + 16; % for blank character
for i = 1:26
    load(['Alphabet/Letter' char(i+64) '.mat']);
    rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
    PC = PC + length(bytes);
end

disp(['Maps section starts at: ' dec2hex(PC,4)]);

load('map.mat');
map1_address = dec2hex(PC,4);
disp(['Map1 starts at: ' map1_address]);
rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
PC = PC + length(bytes);

load('photo_map_deduplicated.mat');
photo_map_address = dec2hex(PC,4);
disp(['photo map starts at: ' photo_map_address]);
rom(PC+1:PC+length(tile_map)) = hex2dec(tile_map);
PC = PC + length(bytes);

load('credits_map.mat');
credits_map_address = dec2hex(PC,4);
disp(['credits map starts at: ' credits_map_address]);
rom(PC+1:PC+length(bytes)) = hex2dec(bytes)+offset_for_letter_tiles;
PC = PC + length(bytes);

disp(['End of graphics section: ' dec2hex(PC,4)])