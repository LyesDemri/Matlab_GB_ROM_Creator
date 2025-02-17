function read_from_HL_address_to_A(address)
    global PC;global rom;
    address = dec2hex(hex2dec(address),4);
    write_to_HL(address);
    rom(PC+1) = hex2dec('7E');
    PC = PC+1;
end