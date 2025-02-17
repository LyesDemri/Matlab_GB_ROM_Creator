function HALT()
    global PC;global rom;
    rom(PC+1) = hex2dec('76'); PC=PC+1;
end

