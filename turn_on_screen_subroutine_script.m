disp(['turn on screen subroutine: ', dec2hex(PC)]);
turn_on_screen = dec2hex(PC,4);
PUSH_HL();
LD_HL(LCD_control);
SET_7_pHLp();
POP_HL();
RET();