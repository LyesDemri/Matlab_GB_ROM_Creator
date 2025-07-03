function INC_SP()
    global PC; global rom;
    rom(PC+1) = hex2dec('33'); PC = PC+1;
end