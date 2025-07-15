%Subroutine to copy sprite from ROM to VRAM:
disp(['print character subroutine: ', dec2hex(PC)]);
print_character = dec2hex(PC,4);

%writes byte contained in register A at address of cursor (main program
%must define cursor_address variable)
%increments cursor address

PUSH_BC();
PUSH_DE();

LD_HL(cursor_address_H);
LD_B_pHLp();
INC_HL();
LD_C_pHLp();
LD_H_B();
LD_L_C();
LD_pHLp_A();

LD_DE(cursor_address_H);
CALL(increment_16bit_register);

POP_DE();
POP_BC();
RET();