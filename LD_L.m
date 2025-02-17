function LD_L(value)
    global PC;global rom;
    rom(PC+1) = hex2dec('2E');  %LD H
    rom(PC+2) = hex2dec(value);
    PC = PC+2;
end

