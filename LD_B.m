function LD_B(value)
    global PC; global rom;
    rom(PC+1) = hex2dec('06'); PC = PC+1;
    rom(PC+1) = hex2dec(value); PC = PC+1;
end

