function letter_tiles_address = load_alphabet(path)

global rom;
global PC;

disp(['alphabet tiles start at: ' dec2hex(PC)]);
letter_tiles_address = dec2hex(PC,4);
for i = 1:26
    load_tiles([path char(i+64) '.mat']);
end