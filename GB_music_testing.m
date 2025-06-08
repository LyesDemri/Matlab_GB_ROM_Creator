clear;clc;close all;

global rom; rom = uint8(zeros(1,32768));
global PC;

%Variables declaration:
ch1_index_address_H = 'C000';   %this 16-bit variable points to the next note to be played by channel 1
ch1_index_address_L = 'C001';
time_ctr_addr = 'C002';
next_note_timer = 'C003';
next_audio_event_pointer_H = 'C004';
next_audio_event_pointer_L = 'C005';
paramaters_section_start = 'C100';  %section for variables passed to functions

%Subroutines declaration:
subroutine_section_start = '1000';
PC = hex2dec(subroutine_section_start);
disp(['Subroutine section starts at ' dec2hex(PC,4)])
%routines must be declared in an order such that any routine that calls
%another routine is defined last.
handle_timer_interrupt_script;
update_audio_registers_script;

load_music

data_used = PC - hex2dec('1000');
data_left = hex2dec('7FFF') - PC;

setup_gameboy_no_graphics
music_tester_logic

data_used_for_code = PC - hex2dec('0150');
data_left_for_code = hex2dec('1000') - PC;

disp([num2str(data_used) ' bytes of ROM used (excluding code)']);
disp([num2str(data_left) ' bytes of ROM remaining (excluding code)']);
disp([num2str(data_used_for_code) ' bytes of ROM used for code']);
disp([num2str(data_left_for_code) ' bytes of ROM remaining for code']);

compute_global_checksum();

%%%%%%%%%%%%%%%%%%%Write the rom to a file%%%%%%%%%%%%%%%%%%%%%
fid = fopen('music_tester.gb','w');
fwrite(fid,rom);
fclose(fid);

disp('everything worked'); 

