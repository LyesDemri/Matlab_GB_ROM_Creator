%music section starts here:
PC = hex2dec('3000')+1;
disp(['Music section starts at: ', dec2hex(PC,4)]);
event =  {'24','77'; %Left & right volume max
          '25','ED'; %All channels go to Left and Right
          '26','FF'; %Audio on, all channels on
          '10','00'; %no sweep
          '11','80'; %50% duty cycle, Max duration for CH1 timer
          '12','B3'; %Initial volume to the max, decreasing envelope
          '16','40'; %25% duty cycle, Max duration for CH2 timer
          '17','B3'; %Initial volume to the max, decreasing envelope
          '1A','80'; %CH3 DAC ON
          '1C','20'; %CH3 Output level = 100%
          '30','FF'; %Waveform
          '31','FF'; %Waveform
          '32','FF'; %Waveform
          '33','FF'; %Waveform
          '34','FF'; %Waveform
          '35','FF'; %Waveform
          '36','FF'; %Waveform
          '37','FF'; %Waveform
          '38','FF'; %Waveform
          '39','FF'; %Waveform
          '3A','FF'; %Waveform
          '3B','FF'; %Waveform
          '3C','ED'; %Waveform
          '3D','CB'; %Waveform
          '3E','A9'; %Waveform
          '3F','87'}; %Waveform
          
insert_audio_data(event,0,'normal');
          

load('sicilienne_note_values.mat');

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
        rom(PC-1) = rom(PC-1) + 3;
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
