clear_tiles = dec2hex(PC,4);
disp(['clear tiles subroutine: ', dec2hex(PC,4)]);

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

LD_B('07');
LD_HL('8000');
loop1 = dec2hex(PC,4);
    LD_A('FF');
    loop2 = dec2hex(PC,4);
        LD_pHLp('00');
        INC_HL();
        DEC_A();
    JP_NZ(loop2);
    DEC_B();
JP_NZ(loop1);

POP_HL();
POP_DE();
POP_BC();
POP_AF(); 

RET()
