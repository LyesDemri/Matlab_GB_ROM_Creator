disp(['Handle timer interrupt: ', dec2hex(PC,4)]);
handle_timer_interrupt = dec2hex(PC,4);
PUSH_HL();
PUSH_AF();
LD_HL(next_event_timer);    %next_event_timer--
LD_A_pHLp();
CP_A('00');
JR_NZ('00');startif = PC;   %if next_event_timer == 0
    CALL(update_audio_registers);   %start updating audio registers
JR('00');else1 = PC;rom(startif) = else1-startif;
    DEC_A();
    LD_pHLp_A();    %just saving the value of next_event_timer
endif = PC; rom(else1) = endif-else1;
POP_AF();
POP_HL();
RET();