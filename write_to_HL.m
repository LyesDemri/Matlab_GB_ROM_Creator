function write_to_HL(value)
    if length(value) ~= 4
        error('value should have 4 digits');
    end
    LD_HL(value);
end
