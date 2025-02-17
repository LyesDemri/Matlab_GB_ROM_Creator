%Subroutine to copy values to VRAM
update_VRAM = dec2hex(PC,4);
disp(['update VRAM subroutine: ', dec2hex(PC,4)]);

PUSH_AF();
PUSH_HL();

LD_HL(chr_X_pixels);
LD_A_pHLp();
LD_HL('FE01');
LD_pHLp_A();

LD_HL(chr_Y_pixels);
LD_A_pHLp();
LD_HL('FE00');
LD_pHLp_A();

POP_HL();
POP_AF();

RET();