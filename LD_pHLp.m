function LD_pHLp(value)
    global PC;global rom;
    value = dec2hex(hex2dec(value),2);
    rom(PC+1) = hex2dec('36');  PC=PC+1;
    rom(PC+1) = hex2dec(value);PC=PC+1;
end

