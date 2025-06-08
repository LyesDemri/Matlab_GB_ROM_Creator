disp(['handle timer interrupt: ' dec2hex(PC,4)]);
handle_timer_interrupt = dec2hex(PC,4);

PUSH_HL();
PUSH_AF();
LD_HL(next_note_timer);
LD_A_pHLp();
DEC_A();
JR_NZ('00');startif = PC;
    CALL(update_audio_registers);
endif = PC;rom(startif) = dec2hex(endif-startif,2);

POP_AF();
POP_HL();

RET();