clear;clc;close all;     

load('perfection.mat')
load('note_values.mat')
load('note_values_CH3.mat');

for t = 1:size(notes,2)
    for i = 1:size(notes,1)
        if strcmp(notes{i,t},'sil')
            %add event to shut off current channel
            p{i,t} = '0FFF';
        elseif strcmp(notes{i,t},'(L)') || length(notes{i,t})==0
        else 
            if t < 3
                for j = 1:size(note_values,1)   %loop to look for note
                    if strcmp(note_values{j,1}, notes{i,t})
                        %add event to trigger note
                        p{i,t} = ['8' note_values{j,2}];
                        break;
                    end
                end
            else
                for j = 1:size(note_values_CH3,1)   %loop to look for note
                    if strcmp(note_values_CH3{j,1}, notes{i,t})
                        %add event to trigger note
                        p{i,t} = ['8' note_values_CH3{j,2}];
                        break;
                    end
                end
            end
        end
    end
end



p

save('perfection_note_values.mat','p');

GB_music_tester_lite