function JP_NZ(address)
    global PC;global rom;
    rom(PC+1) = hex2dec('C2');PC = PC+1;
    rom(PC+1) = hex2dec(address(3:4));PC = PC+1;
    rom(PC+1) = hex2dec(address(1:2));PC = PC+1;
end
