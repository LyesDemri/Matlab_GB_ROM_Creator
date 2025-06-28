function INC_A()
    global PC; global rom;
    rom(PC+1) = hex2dec('3C'); PC = PC+1;
end