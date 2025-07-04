clear;clc;close all;
period_value=3;
frequency = 65536/(2048-period_value)
frequency=64.0939
period_value = round(2048-(65536/frequency))
if 0
  for p=0:2047
    f(p+1)=131072/(2048-p); 
  end
  plot(0:2047,f)
  xlim([0,2000])
  xlabel('period value');
  ylabel('frequency');
  %disp([0:2047;f]');
  disp([0:1500;f(1:1501)]');
end
f=27.5/2;
notes = {'A ', 'A#', 'B ', 'C ' , 'C#', 'D ', 'D#', 'E ', 'F ', 'F#', 'G ', 'G#'};
octave=0;
l = 1;
for o=1:10
  for n=1:12
    p = round(2048-(65536/f));
    disp([notes{n} num2str(octave) ': ' num2str(p) ' ' dec2hex(p,3) ' (' num2str(f) ' Hz)']);
    note_values_CH3(l,:) = {[notes{n} num2str(octave)] dec2hex(p,3)};
    l = l+1;
    f = f*nthroot(2,12);
  end
  octave = octave+1;
end

note_values_CH3
note_values_CH3{1,2}

save('note_values_CH3.mat','note_values_CH3');