disp(['Call next screen subroutine: ' dec2hex(PC,4)]);
load_next_screen = dec2hex(PC,4);

%the "arguments" for the subroutine will be stored in the stack

DEC_SP();
% POP_DE();   %SP isn't pointing to the value I want;
% LD_HL('C100');  %place to store DE;
% LD_pHLp_D();    %store DE which contains SP (which contains PC)
% INC_HL();
% LD_pHLp_E();

POP_AF();   %1/ new value for chr_X or chr_Y
POP_HL();   %2/ address of chr_X or chr_Y

LD_pHLp_A(); 

POP_HL();   %3/ address of chr_X_pixels or chr_Y_pixels
POP_AF();   %4/ new value for chr_X_pixels or chr_Y_pixels

LD_pHLp_A();

%wait for VBlank to arrive
CALL(wait_for_vblank);
%turn off screen
LD_HL('FF40');RES_7_pHLp();

%Load next map
%Take current map address and substract 360 from it
LD_HL(current_map_address_H);LD_D_pHLp(); %DE = current map address
LD_HL(current_map_address_L);LD_E_pHLp();

POP_HL();   %5/ value to add to current map address
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
LD_HL(character_coordinates_H);LD_D_pHLp();
LD_HL(character_coordinates_L);LD_E_pHLp();
POP_HL();   %6/ value to add to character_coordinates
ADD_HL_DE();
LD_D_H();LD_E_L();
LD_HL(character_coordinates_H);LD_pHLp_D();
LD_HL(character_coordinates_L);LD_pHLp_E();

%Bring back PC into SP through DE
% LD_HL('C100');
% LD_D_pHLp();
% INC_HL();
% LD_E_pHLp();
% PUSH_DE();
LD_A('08');
loop1 = dec2hex(PC,4);
    INC_SP();
    DEC_A();
JP_NZ(loop1);

RET();