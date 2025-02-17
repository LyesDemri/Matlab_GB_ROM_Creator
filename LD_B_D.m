function LD_B_D()
    global PC;global rom;
    rom(PC+1) = hex2dec('42');  PC=PC+1;
end