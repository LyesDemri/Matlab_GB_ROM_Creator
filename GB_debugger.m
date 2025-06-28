clear; clc; close all;

global rom;
global PC;

rom = uint8(zeros(1,2^15));

%variables:
cursor_address_H = 'C000';
cursor_address_L = 'C001';
register_address_H = 'C002';
register_address_L = 'C003';
tiles_left = 'C004';
lines_left = 'C005';

PC = hex2dec('1000');
%Subroutines:
vblank_subroutine_script;
map_copy_subroutine_script;
sprite_copy_subroutine_script;
increment_16bit_register_script;
print_nibble_script;
print_register_content_script;
print_register_script;
skip_line_script;
clear_VRAM_script;
print_registers_script;

%import graphics
letter_tiles_address = dec2hex(PC,4);

disp(['number tiles start at: ' dec2hex(PC,4)]);
PC = PC + 16; % for blank character
for i = 1:10
    %disp(['Letter ' char(i+64) ' tiles start at: ' dec2hex(PC,4)]);
    load(['Alphabet/Number' char(i+47) '.mat']);
    rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
    PC = PC + length(bytes);
end

disp(['letter tiles start at: ' dec2hex(PC,4)]);
for i = 1:26
    %disp(['Letter ' char(i+64) ' tiles start at: ' dec2hex(PC,4)]);
    load(['Alphabet/Letter' char(i+64) '.mat']);
    rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
    PC = PC + length(bytes);
end

%write map
disp(['map starts at: ' dec2hex(PC,4)]);
map_address = dec2hex(PC,4);
for i = 0:27
  rom(PC) = i;
  PC = PC + 1;
end


%skip header
PC = hex2dec('100');
NOP();
JP('0150');
write_header('GB debugger');

%initialization
PC = hex2dec('0150');

%initialize screen
CALL(wait_for_vblank);

%turn off screen
LD_HL('FF40');RES_7_pHLp();

%BG & Window tile data area = 8800–8FFF
SET_4_pHLp(); 
SET_0_pHLp(); 

%clear VRAM
CALL(clear_VRAM);

%write text tiles to VRAM
LD_BC(letter_tiles_address);LD_DE('8000');
LD_L('24');
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);

%address of register to print
write_to_address('C0',register_address_H)
write_to_address('00',register_address_L)

CALL(print_registers)

%palette info
write_to_address('E4','FF47')

%turn on screen
LD_HL('FF40');SET_7_pHLp();

JP(dec2hex(PC,4));

compute_global_checksum();

fid = fopen('gb_debugger.gb','w');
fwrite(fid, rom); 
fclose(fid); 

disp('ROM written successfully');
