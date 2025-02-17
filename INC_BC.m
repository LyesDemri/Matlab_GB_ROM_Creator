function INC_BC()
    global PC; global rom;
    rom(PC+1) = hex2dec('03'); PC = PC+1;
end

