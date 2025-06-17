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