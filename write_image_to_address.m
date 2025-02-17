function write_image_to_address(bytes,address)
    %better not use this function (suboptimal behavior)
    global PC;global rom;
    for i=1:length(bytes)
        write_to_address(bytes{i},address);
        address = dec2hex((hex2dec(address)+1),4);
    end
end
