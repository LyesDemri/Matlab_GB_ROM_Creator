disp(['Call right screen script: ' dec2hex(PC,4)]);
PUSH_BC();
LD_HL(chr_X);LD_pHLp('00'); % chr_X = 0
LD_HL(chr_X_pixels); % (FE01) <- (FE01) - 8*19
LD_A_pHLp();
SUB('98');
LD_pHLp_A();
%wait for VBlank to arrive
CALL(wait_for_vblank);
%turn off screen
LD_HL('FF40');RES_7_pHLp();
%Load next map
%Take current map address and add 360 to it
LD_HL(current_map_address_H);LD_D_pHLp();
LD_HL(current_map_address_L);LD_E_pHLp();
LD_HL(dec2hex(360,4));
ADD_HL_DE();
LD_B_H();LD_C_L();
LD_HL(current_map_address_H);LD_pHLp_B();
LD_HL(current_map_address_L);LD_pHLp_C();
LD_HL('9800');  %start target address
CALL(copy_map);
%Turn screen back on
LD_HL('FF40');SET_1_pHLp();   %turn OBJ on
LD_HL('FF40');SET_7_pHLp();   %turn screen back on
%update character coordinates
%character_coordinates += 0x155
LD_HL(character_coordinates_H);LD_D_pHLp();
LD_HL(character_coordinates_L);LD_E_pHLp();
LD_HL('0155');
ADD_HL_DE();
LD_D_H();LD_E_L();
LD_HL(character_coordinates_H);LD_pHLp_D();
LD_HL(character_coordinates_L);LD_pHLp_E();    
POP_BC();