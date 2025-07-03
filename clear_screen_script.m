clear_screen = dec2hex(PC,4);
disp(['clear_screen function starts at: ' clear_screen]);

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

LD_A('FF');
LD_HL('9800');
loop1 = dec2hex(PC,4);
    LD_pHLp('00');
    INC_HL();
    DEC_A();
JP_NZ(loop1);

LD_A('68');
loop1 = dec2hex(PC,4);
    LD_pHLp('00');
    INC_HL();
    DEC_A();
JP_NZ(loop1);

POP_HL();
POP_DE();
POP_BC();
POP_AF(); 

RET();