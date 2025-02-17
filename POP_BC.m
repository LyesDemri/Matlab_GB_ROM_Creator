function POP_BC()
    global PC; global rom;
    rom(PC+1) = hex2dec('C1');PC = PC+1;
end

