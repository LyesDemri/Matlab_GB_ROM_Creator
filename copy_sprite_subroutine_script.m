%Subroutine to copy sprite from ROM to VRAM:
disp(['sprite copy subroutine: ', dec2hex(PC)]);
copy_sprite = dec2hex(PC,4);
PUSH_AF();
PUSH_HL();
LD_L('10'); %will act as a counter
copy_sprite_loop = PC;
    LD_A_pBCp();    %bring a value from BC (source) to A
    LD_pDEp_A();    %take value from A to DE
    INC_BC();
    INC_DE();
    DEC_L();
JP_NZ(dec2hex(copy_sprite_loop,4));
POP_HL();
POP_AF();
RET();