print_nibble = dec2hex(PC,4);
disp(['print nibble subroutine: ', dec2hex(PC,4)]);

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

AND_A('0F')
INC_A();

LD_HL(cursor_address_H);
LD_D_pHLp();
INC_HL();
LD_E_pHLp();
LD_pDEp_A();

LD_DE(cursor_address_H);
CALL(increment_16bit_register);

LD_HL(tiles_left);
DEC_pHLp();

POP_HL();
POP_DE();
POP_BC();
POP_AF(); 

RET()
