function JP(address)
    global PC;global rom;
    address = dec2hex(hex2dec(address),4);
    rom(PC+1) = hex2dec('C3');
    rom(PC+3) = hex2dec(address(1:2));
    rom(PC+2) = hex2dec(address(3:4));
    PC = PC+3;
end

