function number_tiles_address = load_numbers(path)

global rom;
global PC;

disp(['number tiles start at: ' dec2hex(PC)]);
number_tiles_address = dec2hex(PC,4);
for i = 0:9
    load_tiles([path num2str(i) '.mat']);
end