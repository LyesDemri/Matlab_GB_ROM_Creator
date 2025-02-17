function INC_H()
    global PC;global rom;
    rom(PC+1) = hex2dec('24');PC = PC+1;
end

