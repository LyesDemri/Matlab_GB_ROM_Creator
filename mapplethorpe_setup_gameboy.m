%activate timer interrupts
LD_HL('FFFF');LD_pHLp('04');
%put right values for timer
LD_HL('FF04');LD_pHLp('80');
LD_HL('FF05');LD_pHLp('00');
LD_HL('FF06');LD_pHLp('00');
LD_HL('FF07');LD_pHLp('04');

%set game_state to 0
LD_HL(game_state);LD_pHLp('00');

%initialize music pointer
LD_HL(next_audio_event_pointer_H);LD_pHLp('30');
LD_HL(next_audio_event_pointer_L);LD_pHLp('00');
LD_HL(next_event_timer);LD_pHLp('01');

%Maybe displaying the very first screen should be part of the game loop
%instead of the setting up of the game boy
%copy image tiles from ROM to RAM
%wait for vblank and turn off screen
CALL(turn_off_screen);

CALL(clear_tiles);
CALL(clear_screen);

%write character tiles in 
LD_BC(number_tiles_address);LD_DE('8300');%insert here so it respects ASCII
%10 tiles for number sprites
LD_L('0A');
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);
LD_BC(letter_tiles_address);LD_DE('8410');%insert here so it respects ASCII
LD_L('1A'); %26 tiles left for alphabet letters
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);

%initialize cursor position: cursor_address = 9800
LD_HL(cursor_address_H);
LD_pHLp('98');
INC_HL();
LD_pHLp('00');

LD_HL(first_screen_text);
LD_B_pHLp();
INC_HL();
loop1 = dec2hex(PC,4);
    LD_A_pHLp();
    CALL(print_character);
    INC_pHLp();
    DEC_B();
JP_NZ(loop1);

%BG palette settings
write_to_address('D8','FF47')

%turn screen back on:
CALL(turn_on_screen);
EI();

