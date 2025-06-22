%graphics come after the subroutine section
disp(['Start of graphics: ' dec2hex(PC,4)])

happy_face_address = load_tiles('happy_face_bytes.mat');
wall_address = load_tiles('Wall.mat');
sad_face_address = load_tiles('sad_face_bytes.mat');
lyes_photo_tiles_address = load_tiles('photo_deduplicated.mat');
offset_for_letter_tiles = (PC - hex2dec(lyes_photo_tiles_address))/16;
letter_tiles_address = load_alphabet('Alphabet/Letter');

disp(['Maps section starts at: ' dec2hex(PC,4)]);

maps_address = load_tiles('map.mat');
photo_map_address = load_tiles('photo_map_deduplicated.mat');
credits_map_address = load_tiles('credits_map.mat', false, offset_for_letter_tiles);

disp(['End of graphics section: ' dec2hex(PC,4)])