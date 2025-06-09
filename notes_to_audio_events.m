clear;clc;close all;

notes = {'B 4','B 2';
         'A#4','B 2';
         'B 4','B 2';
         'C#4','sil';
         
         'D 4','F#2';
         'C#4','sil';
         'B 4','F#2';
         'A#4','F#2';
         
         'B 4','B 2';
         'A#4','sil';
         'B 4','B 2';
         'C#4','sil';
         
         'D 4','A 3';
         'C#4','A 3';
         'D 4','A 3';
         'E 4','sil';
         
         'F#4','B 2';
         'E 4','sil';
         'D 4','B 2';
         'C#4','B 2'
         
         'D 4','F#2';
         'C#4','sil';
         'D 4','F#2';
         'E 4','sil'
         
         'F#4','B 2';
         'E 4','B 2';
         'F#4','B 2';
         'G 4','sil';
         
         'A 5','A 3';
         'G 4','sil';
         'F#4','A 3';
         'E 4','A 3';
         
         'F#4','D 2';
         'E 4','sil';
         'D 4','D 2';
         'C#4','sil';
         
         'D 4','A 3';
         'E 4','A 3';
         'F#4','A 3';
         'G 4','sil';
         
         'F#4','D 2';
         'E 4','sil';
         'F#4','D 2';
         'A 5','D 2';
         
         'G 4','G 2';
         'F#4','(L)';
         'E 4','(L)';
         'D 4','(L)';

         'B 4','B 2';
         'A#4','B 2';
         'B 4','B 2';
         'C#4','sil';
         
         'D 4','F#2';
         'C#4','sil';
         'B 4','F#2';
         'A#4','F#2';
         
         'B 4','B 2';
         'A#4','sil';
         'B 4','B 2';
         'C#4','sil';
         
         'D 4','A 3';
         'C#4','A 3';
         'D 4','A 3';
         'E 4','sil'
         
         'F#4','B 2';
         'E 4','sil';
         'D 4','B 2';
         'C#4','B 2'
         
         'D 4','F#2';
         'C#4','sil';
         'D 4','F#2';
         'E 4','sil'
         
         'F#4','B 2';
         'E 4','B 2';
         'F#4','B 2';
         'G 4','sil';
         
         'A 5','A 3';
         'G 4','sil';
         'F#4','A 3';
         'E 4','A 3';
         
         'F#4','D 2';
         'E 4','sil';
         'D 4','D 2';
         'C#4','sil';
         
         'D 4','A 3';
         'E 4','A 3';
         'F#4','A 3';
         'G 4','sil';
         
         'F#4','D 2';
         'E 4','sil';
         'F#4','D 2';
         'A 5','D 2';
         
         'G 4','G 2';
         'F#4','(L)';
         'E 4','(L)';
         'D 4','(L)';
         
         'A 5','D 2';
         'F#4','(L)';
         'E 4','(L)';
         'D 4','(L)';
         
         'G 4','E 2';
         'F#4','(L)';
         'E 4','(L)';
         'D 4','(L)';
         
         'F#4','B 2';
         'D 4','(L)';
         'D 4','(L)';
         'C#4','(L)';
         
         'E 4','F#2';
         'C#4','(L)';
         'C#4','(L)';
         'A#4','(L)'};
     

load('note_values.mat')

for t = 1:size(notes,2)
    for i = 1:size(notes,1)
        if strcmp(notes{i,t},'sil')
            %add event to shut off current channel
            p{i,t} = '0FFF';
        elseif strcmp(notes{i,t},'(L)')
        else 
            for j = 1:size(note_values,1)   %loop to look for note
                if strcmp(note_values{j,1}, notes{i,t})
                    %add event to trigger note
                    p{i,t} = ['8' note_values{j,2}];
                    break;
                end
            end
        end
    end
end

p

save('perfection_note_values.mat','p');

%GB_music_tester_lite