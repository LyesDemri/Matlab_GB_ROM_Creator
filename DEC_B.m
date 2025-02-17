function DEC_B()
    global PC; global rom;
    rom(PC+1) = hex2dec('05'); PC = PC+1;
end

