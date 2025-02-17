function PUSH_AF()
    global PC; global rom;
    rom(PC+1) = hex2dec('F5');PC = PC+1;
end