function ADD_SP(value)
    global PC;global rom;
    rom(PC+1) = hex2dec('E8'); PC=PC+1;
    rom(PC+1) = hex2dec(value); PC=PC+1;
end
