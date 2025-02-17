function LD_D(value)
    global PC; global rom;
    rom(PC+1) = hex2dec('16'); PC=PC+1;
    rom(PC+1) = hex2dec(value); PC=PC+1;
end

