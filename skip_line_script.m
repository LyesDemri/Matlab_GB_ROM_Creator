skip_line = dec2hex(PC,4);
disp(['skip line subroutine: ', dec2hex(PC,4)]);

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

loop1 = dec2hex(PC,4);
    LD_DE(cursor_address_H);
    CALL(increment_16bit_register);
    LD_HL(tiles_left);
    DEC_pHLp();
JP_NZ(loop1);

LD_pHLp('20');

POP_HL();
POP_DE();
POP_BC();
POP_AF(); 

RET()
