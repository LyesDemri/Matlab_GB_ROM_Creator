function write_to_address(value,address)
    global PC;global rom;
    value = dec2hex(hex2dec(value),2);
    address = dec2hex(hex2dec(address),4);
    write_to_HL(address);
    rom(PC+1) = hex2dec('36');  %LD (HL)
    rom(PC+2) = hex2dec(value);
    PC = PC+2;
end