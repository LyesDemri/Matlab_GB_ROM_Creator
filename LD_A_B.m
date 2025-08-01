function LD_A_B()
    global PC;global rom;
    rom(PC+1) = hex2dec('78');  PC=PC+1;
end 