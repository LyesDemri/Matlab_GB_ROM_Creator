LD_A(dec2hex(40*4));
LD_HL('FE00');
loop = dec2hex(PC,4);
    LD_pHLp('00');
    INC_HL();
    DEC_A();
JP_NZ(loop);