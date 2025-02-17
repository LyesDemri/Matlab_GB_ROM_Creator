disp(['Call left screen script: ' dec2hex(PC,4)]);
PUSH_BC();  %B is used for the controls, so save it
% chr_X = 19
LD_HL(chr_X);
LD_pHLp(dec2hex(19)); 
% chr_X_pixels = chr_X_pixels + 8*19
LD_HL(chr_X_pixels); 
LD_A_pHLp();
ADD('98');
LD_pHLp_A();
%wait for VBlank to arrive
CALL(wait_for_vblank);
%turn off screen
LD_HL('FF40');RES_7_pHLp();
%Load next map
%Take current map address and substract 360 from it
LD_HL(current_map_address_H);LD_D_pHLp(); %DE = current map address
LD_HL(current_map_address_L);LD_E_pHLp();
LD_HL('FE98');  %2's complement of 360
ADD_HL_DE();
LD_B_H();LD_C_L();      %BC = HL
LD_HL(current_map_address_H);LD_pHLp_B();   %current map address = BC
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
LD_HL('FEAB');  %2's complement of 341
ADD_HL_DE();
LD_D_H();LD_E_L();
LD_HL(character_coordinates_H);LD_pHLp_D();
LD_HL(character_coordinates_L);LD_pHLp_E();    
POP_BC();