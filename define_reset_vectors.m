%reset_vectors
oldPC = PC;

PC = hex2dec('0048');
CALL(handle_STAT_interrupt);
RETI();

PC = hex2dec('0050');
CALL(load_next_note);
RETI();

PC = oldPC; clear oldPC;