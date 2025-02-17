function SET_4_pHLp()
    global PC; global rom;
    rom(PC+1) = hex2dec('CB');PC = PC+1;
    rom(PC+1) = hex2dec('E6');PC = PC+1;
end