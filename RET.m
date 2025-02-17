function RET()
    global PC; global rom;
    rom(PC+1) = hex2dec('C9');PC = PC+1;
end

