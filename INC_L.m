function INC_L()
    global PC;global rom;
    rom(PC+1) = hex2dec('2C');PC = PC+1;
end

