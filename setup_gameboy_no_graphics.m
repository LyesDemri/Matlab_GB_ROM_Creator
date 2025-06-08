define_music_tester_reset_vectors

%Main program  will begin at 0x0100
PC = hex2dec('0100');
%skip cartridge header
NOP();
JP('150');
write_header('Music Tester');

PC = hex2dec('150');

%sound settings
write_to_address('80','FF26');  %Audio ON
write_to_address('FF','FF25');  %All channels on
write_to_address('77','FF24');  %Left/Right Volume Max

write_to_address(tempo_period,time_ctr_addr);
write_to_address('00',note_pointer_addr);

write_to_address(music_start_address(1:2),ch1_index_address_H);
write_to_address(music_start_address(3:4),ch1_index_address_L);

%activate Timer interruptions
LD_HL('FFFF');
SET_2_pHLp();

%set Timer start value
LD_HL('FF06');
LD_A('00');
LD_pHLp_A();
 
%activate TIMA with low update frequency
LD_HL('FF07');
SET_2_pHLp();
RES_1_pHLp();
RES_0_pHLp();

EI();