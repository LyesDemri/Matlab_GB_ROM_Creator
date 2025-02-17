function RETI()
    global PC;global rom;
    rom(PC+1) = hex2dec('D9');PC=PC+1;
end