load('music.mat');
music_start_address = dec2hex(PC,4);
disp(['Music section starts at: ' dec2hex(PC,4)]);
rom(PC+1:PC+length(music)) = hex2dec(music);
PC = PC + length(music);

disp(['End of music section: ' dec2hex(PC,4)])