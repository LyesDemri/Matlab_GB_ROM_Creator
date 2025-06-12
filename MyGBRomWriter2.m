clear;clc;close all;

global rom; rom = uint8(zeros(1,32768));
global PC;

%Variables declaration:
input_buffer_address = 'C000';  
character_coordinates_H = 'C001';
character_coordinates_L = 'C002';
ch1_index_address_H = 'C003';   %this 16-bit variable points to the next note to be played by channel 1
ch1_index_address_L = 'C004';
time_ctr_addr = 'C005';
note_pointer_addr = 'C006';
chr_X = 'C00A';
chr_Y = 'C00B';
game_state = 'C00C';
chr_X_pixels = 'C00D'; 
chr_Y_pixels = 'C00E';
current_map_address_H = 'C00F';
current_map_address_L = 'C010';

%Subroutines declaration:
subroutine_section_start = '1000';
PC = hex2dec(subroutine_section_start);
disp(['Subroutine section starts at ' dec2hex(PC,4)])
%routines must be declared in an order such that any routine that calls
%another routine is defined last.
vblank_subroutine_script;
sprite_copy_subroutine_script;
map_copy_subroutine_script;
load_next_note_subroutine_script;
toggle_tile_data_script;
update_VRAM_script;
handle_STAT_interrupt_script;

load_graphics
load_music

data_used = PC - hex2dec('1000');
disp([num2str(data_used) ' bytes of ROM used (excluding main program)']);
data_left = hex2dec('7FFF') - PC;
disp([num2str(data_left) ' bytes of ROM remaining (excluding main program)']);

setup_gameboy

game_logic

data_used_for_code = PC - hex2dec('0150');
disp([num2str(data_used_for_code) ' bytes of ROM used for main program']);
data_left_for_code = hex2dec('1000') - PC;
disp([num2str(data_left_for_code) ' bytes of ROM remaining for main program']);

compute_global_checksum();

%%%%%%%%%%%%%%%%%%%Write the rom to a file%%%%%%%%%%%%%%%%%%%%%
fid = fopen('infinity_maze.gb','w');
fwrite(fid,rom);
fclose(fid);

disp('everything worked'); 

