function JR_Z(e)
    global PC;global rom;
    rom(PC+1) = hex2dec('28');PC = PC+1;
    rom(PC+1) = hex2dec(e);PC = PC+1;
end

