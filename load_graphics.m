%graphics come after the subroutine section
disp(['Start of graphics: ' dec2hex(PC,4)])

happy_face_address = load_tiles('happy_face_bytes.mat');
wall_address = load_tiles('Wall.mat');
sad_face_address = load_tiles('sad_face_bytes.mat');

load('photo_deduplicated.mat');
lyes_photo_tiles_address = dec2hex(PC,4);
disp(['photo tiles bytes start at: ' lyes_photo_tiles_address]);
rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
PC = PC + length(bytes);

lyes_photo_tiles_address = load_tiles('photo_deduplicated.mat');

offset_for_letter_tiles = (PC - hex2dec(lyes_photo_tiles_address))/16;

letter_tiles_address = dec2hex(PC,4);
disp(['alphabet tiles start at: ' dec2hex(PC)]);
PC = PC + 16; % for blank character
for i = 1:26
    load_tiles(['Alphabet/Letter' char(i+64) '.mat']);
end

disp(['Maps section starts at: ' dec2hex(PC,4)]);
maps_address = load_tiles('map.mat');
photo_map_address = load_tiles('photo_map_deduplicated.mat');
credits_map_address = load_tiles('credits_map.mat', false, offset_for_letter_tiles);

disp(['End of graphics section: ' dec2hex(PC,4)])