function ADC_A_D()
    global PC;global rom;
    rom(PC+1) = hex2dec('8A');  PC=PC+1;
end