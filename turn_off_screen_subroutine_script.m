%Subroutine to turn off screen
disp(['turn off screen subroutine: ', dec2hex(PC)]);
turn_off_screen = dec2hex(PC,4);
PUSH_HL();
CALL(wait_for_vblank);
LD_HL(LCD_control);
RES_7_pHLp();
POP_HL();
RET();