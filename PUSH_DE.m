function PUSH_DE()
    global PC; global rom;
    rom(PC+1) = hex2dec('D5');PC = PC+1;
end

