function DEC_BC()
    global PC; global rom;
    rom(PC+1) = hex2dec('0B'); PC = PC+1;
end

