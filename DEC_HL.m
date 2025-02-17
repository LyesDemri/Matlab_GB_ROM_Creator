function DEC_HL()
    global PC;global rom;
    rom(PC+1) = hex2dec('2B'); PC = PC+1;
end

