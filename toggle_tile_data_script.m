%Subroutine to set LCDC.4 to 0
toggle_tile_data = dec2hex(PC,4);
disp(['toggle tile data subroutine: ' dec2hex(PC,4)]);
RET();
% PUSH_HL();
% LD_HL('FF40');
% RES_4_pHLp();
% POP_HL();
% RET();
