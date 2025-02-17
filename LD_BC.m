function LD_BC(value)
    global PC; global rom;
    rom(PC+1) = hex2dec('01'); PC = PC+1;
    rom(PC+1) = hex2dec(value(3:4));PC = PC+1;
    rom(PC+1) = hex2dec(value(1:2));PC = PC+1;
end

