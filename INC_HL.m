function INC_HL()
    global PC; global rom;
    rom(PC+1) = hex2dec('23');PC = PC+1;
end

