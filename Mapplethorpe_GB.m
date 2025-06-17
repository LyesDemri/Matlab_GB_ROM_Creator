clear;clc;close all;

%The Flowers of Robert Maplethorpe: Requirements
%welcome screen
    %white screen with black text saying "this game was made for the GB
    %contest"
%flowers
    %as many flowers as possible
%ending screen
    %RIP Robert Maplethorpe (1946-1989), thanks for playing
%Some music by beethoven throughout

global rom;
global PC;

rom = uint8(zeros(1,2^15));

%Variable definitions:
next_audio_event_pointer_H = 'C000';
next_audio_event_pointer_L = 'C001';
next_event_timer = 'C002';
input_buffer_address = 'C003';  


%Subroutines:
PC = hex2dec('1000');
update_audio_registers;
mapplethorpe_handle_timer_interrupt
sprite_copy_subroutine_script;
map_copy_subroutine_script;
vblank_subroutine_script;

%Load graphics
mapplthorpe_load_graphics

%define reset vector
PC = hex2dec('50');
CALL(handle_timer_interrupt);
RETI();

%starting point of GB CPU
PC = hex2dec('0100');
JP('0150');

%Main program:
PC = hex2dec('0150');
%activate timer interrupts
LD_HL('FFFF');LD_pHLp('04');
%put right values for timer
LD_HL('FF07');LD_pHLp('04');
LD_HL('FF05');LD_pHLp('00');
%initialize music pointer
LD_HL(next_audio_event_pointer_H);LD_pHLp('30');
LD_HL(next_audio_event_pointer_L);LD_pHLp('00');
LD_HL(next_event_timer);LD_pHLp('01');

%copy image tiles from ROM to RAM
%wait for vblank and turn off screen
CALL(wait_for_vblank);
LD_HL('FF40');RES_7_pHLp();

LD_BC(album_cover_tiles_address);LD_DE('8000');
%there are 372 tiles in the photo after dedup
LD_L('FF');
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);
LD_L('74'); %116 tiles left
loop1 = dec2hex(PC,4);
    CALL(copy_sprite);
    DEC_L();
JP_NZ(loop1);

%Load photo map
LD_BC(album_cover_map_address);  %start source address 32D0
LD_HL('9800');  %start target address 9800
CALL(copy_map);

%BG palette settings
write_to_address('D8','FF47')

%turn screen back on:
LD_HL('FF40');SET_7_pHLp();
EI();
JP(dec2hex(PC,4)); %stay here. music handled by interrupts.

%music section starts here:
PC = hex2dec('3000')+1;
disp(['Music section starts at: ', dec2hex(PC,4)]);
event =  {'24','77'; %Left & right volume max
          '25','ED'; %All channels go to Left and Right
          '26','FF'; %Audio on, all channels on
          '10','00'; %no sweep
          '11','80'; %50% duty cycle, Max duration for CH1 timer
          '12','F0'; %Initial volume to the max, decreasing envelope
          '16','40'; %25% duty cycle, Max duration for CH2 timer
          '17','F0'; %Initial volume to the max, decreasing envelope
          '1A','80'; %CH3 DAC ON
          '1C','20'; %CH3 Output level = 100%
          '30','FF'; %Waveform
          '31','00'; %Waveform
          '32','FF'; %Waveform
          '33','FF'; %Waveform
          '34','0F'; %Waveform
          '35','FF'; %Waveform
          '36','FF'; %Waveform
          '37','FF'; %Waveform
          '38','00'; %Waveform
          '39','00'; %Waveform
          '3A','00'; %Waveform
          '3B','00'; %Waveform
          '3C','00'; %Waveform
          '3D','00'; %Waveform
          '3E','00'; %Waveform
          '3F','00'}; %Waveform
          
insert_audio_data(event,0,'normal');
          

load('perfection_note_values.mat');

for n = 1:size(p,1)
    event = {};
    i = 1;
    if ~isempty(p{n,1})
        event = [event;
                {'14', p{n,1}(1:2);
                  '13', p{n,1}(3:4)}];
    end
    if ~isempty(p{n,2})
       event = [event;
               {'19', p{n,2}(1:2);
                '18', p{n,2}(3:4)}];
    end
    if ~isempty(p{n,3})
       event = [event;
               {'1E', p{n,3}(1:2);
                '1D', p{n,3}(3:4)}];
    end
    if ~isempty(event)
        if n ~= size(p,1)
            insert_audio_data(event,2,'normal');
        else 
            insert_audio_data(event,1,'normal');
        end
    else
        error('There are no events to insert!');
    end
end

%this is so it loops
%next_audio_pointer must be set to 0x3000
%we must have the sequence 
%FF     "escape sequence"
%C0-00  next_audio_pointer_high
%30     value to put there
%C0-01  next_audio_pointer_low
%00     value to put there
event_data = {next_audio_event_pointer_H,'30';
              next_audio_event_pointer_L,'36'};
insert_audio_data(event_data,1,'long');

fid = fopen('mapplethorpe_gb_rom.gb','w');
fwrite(fid,rom);
fclose(fid);

disp('Everything worked!');

function insert_audio_data(event_data,time_until_next_event, transfer_type)
    global PC;
    global rom;
    disp(dec2hex(PC-1))
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