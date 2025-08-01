function LD_A_pLITp(value)
    global PC;global rom;
    rom(PC+1) = hex2dec('FA');  PC=PC+1;
    rom(PC+1) = hex2dec(value(3:4));  PC=PC+1;
    rom(PC+1) = hex2dec(value(1:2));  PC=PC+1;
end 