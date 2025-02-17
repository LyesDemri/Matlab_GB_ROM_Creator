function LD_C_A()
    global PC; global rom;global cycles;
    rom(PC+1) = hex2dec('4F'); PC = PC+1;
end

