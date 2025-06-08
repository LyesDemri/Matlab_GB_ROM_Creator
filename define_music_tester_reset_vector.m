%reset_vectors
oldPC = PC;

PC = hex2dec('0050');
CALL(handle_timer_interrupt);
RETI();

PC = oldPC; clear oldPC;