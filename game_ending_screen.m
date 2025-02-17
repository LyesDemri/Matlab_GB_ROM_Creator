%change the game state (leave the gameplay loop)
LD_HL(game_state);LD_pHLp('02');
%turn off screen
CALL(wait_for_vblank);
LD_HL('FF40');RES_7_pHLp();
%Put 0d72 = 0x48 in register LYC:
write_to_address('B4','FF45');
%Activate LYC-generated STAT interrupts
LD_HL('FF41');SET_6_pHLp();
%Activate interrupts from LCD, Vblank and Timer
LD_HL('FFFF');SET_0_pHLp();SET_1_pHLp();
%Copy photo tiles from ROM to RAM
%First half (Tiles 0 to 180):
LD_BC(lyes_photo_tiles_address);LD_DE('8000');
LD_L('DE'); %there are 222 tiles in the photo after dedup
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);
%Copy alphabet tiles from ROM to RAM:
LD_BC(letter_tiles_address);LD_DE('8DE0');
LD_L('1A');
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);

%Load photo map
LD_BC(photo_map_address);  %start source address 32D0
LD_HL('9800');  %start target address 9800
CALL(copy_map);
%Palette for the picture
write_to_address('D8','FF47')

%Activate Window later to write text on it:
%WX = 7, WY = 128
write_to_address('80','FF4A');
write_to_address('07','FF4B');
%LCDC.5 = 1 and LCDC.6 = 1
LD_HL('FF40');SET_5_pHLp();
LD_HL('FF40');SET_6_pHLp();

%Load credits map
LD_BC(credits_map_address);
LD_HL('9C00');
CALL(copy_map);

%Turn screen back on
LD_HL('FF40');RES_1_pHLp();   %turn OBJ off
LD_HL('FF40');SET_7_pHLp();   %turn screen back on