%Subroutine to copy map to Tile map
disp(['map copy subroutine: ', dec2hex(PC)]);
copy_map = dec2hex(PC,4);
    LD_D('03');
    fill_screen_outer_loop = PC;
        LD_E('14');
        fill_row_loop = PC;
            LD_A_pBCp();
            LD_pHLp_A();
            INC_BC();
            INC_L();
            DEC_E();
        JP_NZ(dec2hex(fill_row_loop,4));
        LD_A_L();ADD('C');LD_L_A(); %L+=0x0C
        JR_NZ('00');source=PC;      %if L != 0
            INC_H();
            DEC_D();
        target = PC; rom(source) = target-source;
    JP_NZ(dec2hex(fill_screen_outer_loop,4));
RET();