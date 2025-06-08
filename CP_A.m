function CP_A(value)
    global PC; global rom;
    rom(PC+1) = hex2dec('FE'); PC = PC+1;
    rom(PC+1) = hex2dec(value); PC = PC+1;
end

