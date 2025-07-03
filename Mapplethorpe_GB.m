clear;clc;close all;

%The Flowers of Robert Maplethorpe: Requirements
%welcome screen
    %white screen with black text saying "this game was made for the GB
    %contest"
%flowers
    %as many flowers as possible
%ending screen
    %RIP Robert Maplethorpe (1946-1989), thanks for playing
%Some music by beethoven throughout

global rom;
global PC;

rom = uint8(zeros(1,2^15));

%Variable definitions:
next_audio_event_pointer_H = 'C000';
next_audio_event_pointer_L = 'C001';
next_event_timer = 'C002';
input_buffer_address = 'C003'; 
game_state = 'C004';

%Subroutines:
PC = hex2dec('1000');
update_audio_registers_script;
mapplethorpe_handle_timer_interrupt
copy_sprite_subroutine_script;
copy_map_subroutine_script;
vblank_subroutine_script;
clear_screen_script;
call_screen_2_script;

%Load graphics
%it doesn't really matter if the letters and numbers are stored in ASCII
%order in the ROM. What matters is that they're stored in ASCII order in
%the VRAM when you want to write.
number_tiles_address = load_numbers('Alphabet/Number');
letter_tiles_address = load_alphabet('Alphabet/Letter');
title_screen_tiles_address = load_tiles('calla lily_deduplicated.mat');
rom(marker1) = hex2dec(title_screen_tiles_address(1:2));
rom(marker1-1) = hex2dec(title_screen_tiles_address(3:4));

%map for first screen
first_screen_map_address = dec2hex(PC,4);
first_screen_text = double(upper(' This ROM was made   for the 2025 GB     contest'));
for i=1:length(first_screen_text)
    rom(PC) = first_screen_text(i);
    PC = PC+1;
end

title_screen_map_address = load_tiles('calla lily_map_deduplicated.mat');
rom(marker2) = hex2dec(title_screen_map_address(1:2));
rom(marker2-1) = hex2dec(title_screen_map_address(3:4));

%Load music
mapplethorpe_load_music;

%define reset vector
PC = hex2dec('50');
CALL(handle_timer_interrupt);
RETI();

%starting point of GB CPU
PC = hex2dec('0100');
JP('0150');
write_header(' GB contest 2025');

%Main program:
PC = hex2dec('0150');

mapplethorpe_setup_gameboy;

mapplethorpe_game_loop;

compute_global_checksum();

fid = fopen('mapplethorpe_gb_rom.gb','w');
fwrite(fid,rom);
fclose(fid);

disp('Everything worked!');

