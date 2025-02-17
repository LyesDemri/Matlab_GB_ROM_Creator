function SET_7_pHLp()
    global PC; global rom;
    rom(PC+1) = hex2dec('CB');PC = PC+1;
    rom(PC+1) = hex2dec('FE');PC = PC+1;
end
