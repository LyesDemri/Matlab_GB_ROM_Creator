function LD_C(value)
    global PC; global rom;
    rom(PC+1) = hex2dec('0E'); PC = PC+1;
    rom(PC+1) = hex2dec(value); PC = PC+1;
end


