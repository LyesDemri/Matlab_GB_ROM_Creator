function DEC_SP()
    global PC; global rom;
    rom(PC+1) = hex2dec('3B'); PC = PC+1;
end