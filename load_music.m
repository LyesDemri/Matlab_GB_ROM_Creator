load('music.mat');
music_start_address = dec2hex(PC,4);

%Now we know where the music starts, so we can go back to the
%load_next_note subroutine and write the return address of the music
%pointer
rom(music_start_address_marker_L) = hex2dec(music_start_address(3:4));
rom(music_start_address_marker_H) = hex2dec(music_start_address(1:2));
disp(['Music section starts at: ' dec2hex(PC,4)]);
%write the music data normally
rom(PC+1:PC+length(music)) = hex2dec(music);
PC = PC + length(music);

disp(['End of music section: ' dec2hex(PC,4)])