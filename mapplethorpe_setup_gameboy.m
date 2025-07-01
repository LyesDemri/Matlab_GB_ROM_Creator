%activate timer interrupts
LD_HL('FFFF');LD_pHLp('04');
%put right values for timer
LD_HL('FF04');LD_pHLp('80');
LD_HL('FF05');LD_pHLp('00');
LD_HL('FF06');LD_pHLp('00');
LD_HL('FF07');LD_pHLp('04');

%initialize music pointer
LD_HL(next_audio_event_pointer_H);LD_pHLp('30');
LD_HL(next_audio_event_pointer_L);LD_pHLp('00');
LD_HL(next_event_timer);LD_pHLp('01');

%Maybe displaying the very first screen should be part of the game loop
%instead of the setting up of the game boy
%copy image tiles from ROM to RAM
%wait for vblank and turn off screen
CALL(wait_for_vblank);
LD_HL('FF40');RES_7_pHLp();

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

%Load first screen map
LD_BC(first_screen_map_address);  %start source address
LD_HL('9800');  %start target address 9800
CALL(copy_map);

%BG palette settings
write_to_address('D8','FF47')

%turn screen back on:
LD_HL('FF40');SET_7_pHLp();
EI();

