function NOP()
    global PC;global rom;
    rom(PC+1) = 0; PC = PC + 1;
end

