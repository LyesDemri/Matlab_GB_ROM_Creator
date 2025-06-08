function RLC_C()
    global PC; global rom;
    rom(PC+1) = hex2dec('CB'); PC = PC+1;
    rom(PC+1) = hex2dec('01'); PC = PC+1;
end