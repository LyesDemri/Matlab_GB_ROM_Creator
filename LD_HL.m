function LD_HL(value)
    global PC; global rom;global cycles;
    rom(PC+1) = hex2dec('21'); PC = PC+1;
    rom(PC+1) = hex2dec(value(3:4));PC = PC+1;
    rom(PC+1) = hex2dec(value(1:2));PC = PC+1;
    cycles = cycles + 4;
end

