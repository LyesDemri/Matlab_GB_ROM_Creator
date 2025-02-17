function ADD_HL_BC()
    global PC;global rom;
    rom(PC+1) = hex2dec('09');  PC=PC+1;
end

