function tile_address = load_tiles(filename,varargin)

global PC;
global rom;

if length(varargin)>1
    display_message = varargin{2};
else
    display_message = false;
end

load(filename);
tile_address = dec2hex(PC, 4);
if display_message
    disp(['tile in ' [filename] ' start at: ' tile_address]);
end
rom(PC+1:PC+length(bytes)) = hex2dec(bytes);
PC = PC + length(bytes);
