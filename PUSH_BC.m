function PUSH_BC()
    global PC; global rom;
    rom(PC+1) = hex2dec('C5');PC = PC+1;
end

