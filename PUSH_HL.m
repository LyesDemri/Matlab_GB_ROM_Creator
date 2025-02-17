function PUSH_HL()
    global PC; global rom;
    rom(PC+1) = hex2dec('E5');PC = PC+1;
end

