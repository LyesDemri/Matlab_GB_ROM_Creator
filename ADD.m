function ADD(value)
    %lol
    global PC; global rom;
    rom(PC+1) = hex2dec('C6');PC = PC+1;
    rom(PC+1) = hex2dec(value);PC = PC+1;
end

