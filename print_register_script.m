print_register = dec2hex(PC,4);
disp(['print register subroutine: ', dec2hex(PC,4)]);

%address_H and address_L must contain the address of the register to
%display
%cursor_address_H and cursor_address_L must contain the address where the
%cursor is
PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

LD_HL(register_address_H)
LD_A_pHLp();
CALL(print_register_content)
INC_HL();
LD_A_pHLp();
CALL(print_register_content)

LD_DE(cursor_address_H);
CALL(increment_16bit_register); 
LD_HL(tiles_left);
DEC_pHLp();

LD_HL(register_address_H);
LD_D_pHLp();
INC_HL();
LD_E_pHLp();
LD_H_D();
LD_L_E();
LD_A_pHLp();
CALL(print_register_content)

%logic to return to new line

POP_HL();
POP_DE();
POP_BC();
POP_AF();
RET();