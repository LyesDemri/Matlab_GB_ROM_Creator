function INC_E()
    global PC; global rom;
    rom(PC+1) = hex2dec('1C'); PC = PC+1;
end

