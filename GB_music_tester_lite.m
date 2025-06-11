clear;clc;close all;

global rom;
global PC;

rom = uint8(zeros(1,2^15));

%Variable definitions:
next_audio_event_pointer_H = 'C000';
next_audio_event_pointer_L = 'C001';
next_event_timer = 'C002';

%Subroutines:
PC = hex2dec('1000');
disp(['update audio registers: ', dec2hex(PC,4)]);
update_audio_registers = dec2hex(PC,4);
PUSH_HL();
PUSH_AF();
PUSH_BC();
PUSH_DE();
%B <- number of registers to update
LD_BC(next_audio_event_pointer_H);  %HL <- next_audio_event_pointer
LD_A_pBCp();
LD_H_A();
INC_BC();
LD_A_pBCp;
LD_L_A();
LD_B_pHLp();    %B <- [HL] = [next_audio_event_pointer which is number of registers to update]
update_loop = PC;
    INC_HL();       %HL++
    LD_C_pHLp();    %C = register to be updated (starting from FF00)
    %if register to be updated is FFFF, use regular register transfer ("long" copy)
    LD_A('FF');
    CP_A_C();
    JR_NZ('00');if1=PC;
        %"long" copy
        %read destination address into DE
        INC_HL();
        LD_D_pHLp();
        INC_HL();
        LD_E_pHLp();
        INC_HL();
        LD_A_pHLp();    %read value to store into destination
        LD_pDEp_A();
        LD_A('01');     %to not change value of event audio later
    JR('00');else1=PC;rom(if1)=else1-if1;
        %"fast" copy
        INC_HL();       %HL++
        LD_A_pHLp();    %A = new value
        LDH_pCp_A();    %register = new value
    end1=PC;rom(else1)=end1-else1;
    DEC_B();        %registers left to update--;
JP_NZ(dec2hex(update_loop,4));
INC_HL();       %HL++
LD_D_pHLp();	%D = time to wait before next event
PUSH_HL();      %because HL holds the current audio_event_pointer 
                        %and we want to use it for a quick data transfer
LD_HL(next_event_timer); %next note timer = time to wait before next event
LD_pHLp_D();
POP_HL();
%save address of start of next audio event:
%this should not be done if we've used "long" copy
CP_A('01');
JR_Z('00');if1 = PC;
    INC_HL();
    LD_B_H();   %next_audio_event_pointer <- HL++
    LD_C_L();
    LD_HL(next_audio_event_pointer_H); 
    LD_pHLp_B();
    INC_HL();
    LD_pHLp_C();
endif1 = PC;rom(if1)=endif1-if1;
POP_DE();
POP_BC();
POP_AF();
POP_HL();
RET();

disp(['Handle timer interrupt: ', dec2hex(PC,4)]);
handle_timer_interrupt = dec2hex(PC,4);
PUSH_HL();
PUSH_AF();
LD_HL(next_event_timer);    %next_event_timer--
LD_A_pHLp();
CP_A('00');
JR_NZ('00');startif = PC;   %if next_event_timer == 0
    CALL(update_audio_registers);   %start updating audio registers
JR('00');else1 = PC;rom(startif) = else1-startif;
    DEC_A();
    LD_pHLp_A();    %just saving the value of next_event_timer
endif = PC; rom(else1) = endif-else1;
POP_AF();
POP_HL();
RET();

%starting point of GB CPU
PC = hex2dec('0100');
JP('0150');

%define reset vector
PC = hex2dec('50');
CALL(handle_timer_interrupt);
RETI();

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
          '31','FF'; %Waveform
          '32','FF'; %Waveform
          '33','FF'; %Waveform
          '34','FF'; %Waveform
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

disp(['loop event data: ' dec2hex(PC)])
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
insert_audio_data(event_data,0,'long');

fid = fopen('gb_music_lite_test.gb','w');
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