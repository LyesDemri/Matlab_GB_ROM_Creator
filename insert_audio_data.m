function insert_audio_data(event_data,time_until_next_event, transfer_type)
    global PC;
    global rom;
    %disp(dec2hex(PC-1))
    rom(PC) = size(event_data,1);PC=PC+1; %Number of registers to change
    if strcmp(transfer_type,'long')
        for i = 1:size(event_data,1)
            rom(PC) = hex2dec('FF');PC = PC+1;    %escape sequence
            rom(PC) = hex2dec(event_data{i,1}(1:2));PC = PC+1;    %destination high
            rom(PC) = hex2dec(event_data{i,1}(3:4));PC = PC+1;    %destination high
            rom(PC) = hex2dec(event_data{i,2});PC = PC+1;
        end
    elseif strcmp(transfer_type,'normal')
        for i = 1:size(event_data,1)
            rom(PC) = hex2dec(event_data{i,1}); PC=PC+1;
            rom(PC) = hex2dec(event_data{i,2}); PC=PC+1;
        end
    else
        error('invalid transfer type');
    end
    rom(PC) = time_until_next_event; PC=PC+1;
end