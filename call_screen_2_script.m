call_screen_2 = dec2hex(PC,4);
disp(['call_screen_2 function starts at: ' call_screen_2]);

%calls second screen in the game;

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

%set game_state to 0
LD_HL(game_state);LD_pHLp('01');

%turn off screen
CALL(wait_for_vblank);
LD_HL('FF40');RES_7_pHLp();

CALL(clear_screen);

%Load title screen tiles
LD_BC('0000');marker1 = PC;
LD_DE('8000');
LD_L('5F'); %there are 95 tiles in the photo after dedup
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);

%Load title screen map
LD_HL('0000');marker2 = PC;PUSH_HL();   %1/ source address
LD_HL('9800');PUSH_HL();                %2/ destination address
CALL(copy_map);
ADD_SP('04');

%turn screen back on:
LD_HL('FF40');SET_7_pHLp();

POP_HL();
POP_DE();
POP_BC();
POP_AF(); 

RET();