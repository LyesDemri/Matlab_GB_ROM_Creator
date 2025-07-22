%Subroutine to copy sprite from ROM to VRAM:
disp(['print character subroutine: ', dec2hex(PC)]);
print_character = dec2hex(PC,4);

%sets value stored in BC at addresses HL and HL+1
LD_pHLp_B();
INC_HL();
LD_pHLp_C();

RET();