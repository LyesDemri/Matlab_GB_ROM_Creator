disp(['Main program loop starts at:' dec2hex(PC,4)])
gameloop = PC;    
    %if game_state == 0, display title screen
    LD_HL(game_state);LD_A('00');
    CP_A_pHLp();
    JR_NZ('00');startif0 = PC;
        disp(['Title screen game loop start at : ' dec2hex(PC,4)]);
        LD_HL('FF40');
        SET_4_pHLp();
    endif0 = PC; rom(startif0) = endif0 - startif0; 
    
    %if game_state == 1, use gameplay loop
    LD_HL(game_state);LD_A('01');
    CP_A_pHLp();
    JP_NZ('0000');startif0 = PC; %jump longer than 255 so it's convoluted
        gameplay_loop;
    endif0 = dec2hex(PC,4); 
    rom(startif0-1) = hex2dec(endif0(3:4));
    rom(startif0) = hex2dec(endif0(1:2));
    
    %if game_state == 2, use ending loop
    LD_HL(game_state);LD_A('02');
    CP_A_pHLp();
    JR_NZ('00');startif0 = PC;
        disp(['End screen game loop start at : ' dec2hex(PC,4)]);
        LD_HL('FF40');
        SET_4_pHLp();
    endif0 = PC; rom(startif0) = endif0 - startif0;    
    LD_HL('FF44');
    LD_A_pHLp();
JP(dec2hex(gameloop));

disp(['Main program stops at ' dec2hex(PC,4)]);