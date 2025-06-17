disp(['Main game loop start at : ' dec2hex(PC,4)]);
%We need to set the first nibble of 1100 to read its contents
%To read arrows the first nibble should be 0x2
write_to_address('20','FF00');
LD_HL('FF00');  %get current value of FF00
LD_B_pHLp();
%There should be a way to combine all of this into 1
handle_right_button;
handle_left_button;
handle_up_button;
handle_down_button;

LD_HL(input_buffer_address);  %save previous value of B in C000
LD_pHLp_B();

%Check if player has reached end of game
LD_HL(character_coordinates_H);
%end_address = dec2hex(hex2dec(game_start_address)+1,4);
end_address = dec2hex(hex2dec(maps_address) + 25*20*18 + 14*20,4);
%end_address = '44BC';
LD_A(end_address(1:2));
CP_A_pHLp();
JR_NZ('00');startif = PC;
    LD_HL(character_coordinates_L);
    LD_A(end_address(3:4));
    CP_A_pHLp();
    JR_NZ('00');startif2=PC;
        game_ending_screen
    endif2=PC;rom(startif2)=endif2-startif2;
endif = PC; rom(startif)=endif-startif;

