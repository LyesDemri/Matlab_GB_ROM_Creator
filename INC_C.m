function INC_C()
    global PC; global rom;
    rom(PC+1) = hex2dec('0C'); PC = PC+1;
end

