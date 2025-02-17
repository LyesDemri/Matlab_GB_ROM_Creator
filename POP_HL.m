function POP_HL()
    global PC; global rom;
    rom(PC+1) = hex2dec('E1');PC = PC+1;
end

