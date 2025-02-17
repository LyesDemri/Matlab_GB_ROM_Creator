%handle STAT interrupt, we need to do different things based on the game
%state.
handle_STAT_interrupt = dec2hex(PC,4);
disp(['handle STAT interrupt subroutine: ' dec2hex(PC,4)])

PUSH_AF();
PUSH_BC();
PUSH_HL();
PUSH_DE(); 

%Check game state
LD_HL(game_state);
LD_A_pHLp();
CP(dec2hex(1));
JR_NZ('00');startif0=PC;
    %if player is playing
    CALL(update_VRAM);
JR('00');else0=PC;rom(startif0) = else0-startif0;
    %If we're in the game end screen:
    LD_HL(game_state);
    LD_A_pHLp();
    CP(dec2hex(2));
    JR_NZ('00');startif1=PC;
        CALL(toggle_tile_data);
    endif1=PC;rom(startif1)=endif1-startif1;
endif0=PC;rom(else0) = endif0-else0;

POP_DE(); 
POP_HL();
POP_BC();
POP_AF();

RET();