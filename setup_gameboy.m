define_reset_vectors

%Main program  will begin at 0x0100
PC = hex2dec('0100');
%skip cartridge header
NOP();
JP('150');
write_header();

PC = hex2dec('150');

%BG/OBJ palette settings
write_to_address('E4','FF47')
write_to_address('E4','FF48')
write_to_address('E4','FF49')

%sound settings
write_to_address('80','FF26');  %Audio ON
write_to_address('FF','FF25');  %All channels on
write_to_address('77','FF24');  %Left/Right Volume Max

write_to_address(tempo_period,time_ctr_addr);
write_to_address('00',note_pointer_addr);

write_to_address(music_start_address(1:2),ch1_index_address_H);
write_to_address(music_start_address(3:4),ch1_index_address_L);

%wait for VBlank to arrive
CALL(wait_for_vblank);
%turn off screen
LD_HL('FF40');RES_7_pHLp();
%Copy sprite from ROM to RAM
LD_BC(happy_face_address);  %Source Address (in ROM)
LD_DE('8810');  %Target Address (in VRAM)
CALL(copy_sprite);  %copy_sprite being equal to the address where the subroutine lies
LD_BC(wall_address);LD_DE('8020');CALL(copy_sprite);
LD_BC(sad_face_address);LD_DE('8030');CALL(copy_sprite); 

%write map to screen:
LD_BC(map1_address);  %start source address 3000  
LD_HL('9800');  %start target address 9800
CALL(copy_map);

clear_OAM;

%write sprite to screen
write_to_address('18',chr_Y_pixels);
write_to_address('10',chr_X_pixels);
write_to_address('81','FE02');
write_to_address('00','FE03');

game_start_address = '2091';
write_to_address(game_start_address(1:2),character_coordinates_H);
write_to_address(game_start_address(3:4),character_coordinates_L);
write_to_address('01',chr_X);
write_to_address('01',chr_Y);
write_to_address('01',game_state);
write_to_address(map1_address(1:2),current_map_address_H);
write_to_address(map1_address(3:4),current_map_address_L);

LD_HL('FF40');SET_1_pHLp();   %turn OBJ on
LD_HL('FF40');SET_7_pHLp();   %turn screen back on

%activate LCD interruptions (we'll use this to watch the start of the
%rendering process).
LD_HL('FFFF');
SET_1_pHLp();

%activate Timer interruptions
LD_HL('FFFF');
SET_2_pHLp();

%select LYC == LY for condition for the STAT interrupt
LD_HL('FF41');
SET_6_pHLp();
%set LYC = 0d144;
LD_HL('FF45');
LD_pHLp(dec2hex(144)); %Every time we reach VBlank, call "update_VRAM"

%set Timer start value
LD_HL('FF06');
LD_A('00');
LD_pHLp_A();
 
%activate TIMA with low update frequency
LD_HL('FF07');
SET_2_pHLp();
RES_1_pHLp();
RES_0_pHLp();

EI();