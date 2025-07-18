function ADD_A_E()
    global PC;global rom;
    rom(PC+1) = hex2dec('83');  PC=PC+1;
end