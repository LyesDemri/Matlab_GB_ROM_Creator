function tile_address = load_tiles(filename,varargin)
%arguments:
%filename: file of .mat file containing the bytes of a tile or map to write
%display_message: true to display where the tile or map starts in the rom
%offset: if different than zero, the bytes will be added a value. useful
%for including tiles of different graphics in the VRAM at the same time.


global PC;
global rom;

if length(varargin) > 1
    offset = varargin{2};
else
    offset = 0;
end

if length(varargin) > 0
    display_message = varargin{1};
else
    display_message = false;
end

load(filename);
tile_address = dec2hex(PC, 4);
if display_message
    disp(['tiles in ' [filename] ' start at: ' tile_address]);
end
rom(PC+1:PC+length(bytes)) = hex2dec(bytes)+offset;
PC = PC + length(bytes);
