function LD_H(value)
    global PC;global rom;
    rom(PC+1) = hex2dec('26');  %LD H
    rom(PC+2) = hex2dec(value);
    PC = PC+2;
end

