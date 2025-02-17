function INC_DE()
    global PC; global rom;
    rom(PC+1) = hex2dec('13'); PC = PC+1;
end

