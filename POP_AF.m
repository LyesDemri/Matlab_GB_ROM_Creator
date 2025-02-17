function PUSH_AF()
    global PC; global rom;
    rom(PC+1) = hex2dec('F1');PC = PC+1;
end