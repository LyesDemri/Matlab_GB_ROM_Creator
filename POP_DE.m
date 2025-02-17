function POP_DE()
    global PC; global rom;
    rom(PC+1) = hex2dec('D1');PC = PC+1;
end