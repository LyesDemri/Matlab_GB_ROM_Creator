disp(['update audio registers: ' dec2hex(PC,4)]);
update_audio_registers = dec2hex(PC,4);

PUSH_HL();
PUSH_AF();
PUSH_BC();
PUSH_DE();

%A <- number of registers to update
LD_BC(next_audio_event_pointer_H);
LD_H_pBCp;
INC_BC();
LD_L_pBCp;
LD_A_pHLp();
update_loop = PC;
    INC_HL();       %HL++
    LD_BC_pHLp();   %BC = register to be updated
    INC_HL();       %HL++
    LD_DE_pHLp();   %DE = new value
    LD_pBCp_DE();   %register = new value
    DEC_A();        %registers left to update = registers left to update -1
JP_NZ(dec2hex(update_loop,4));

INC_HL();               %HL++
LD_DE_pHLp();           %DE = time to wait before next event
LD_HL(next_note_timer); %next note timer = time to wait before next event
LD_pHLp_DE();

%save address of start of next audio event:
INC_HL();
LD_BC(next_audio_event_pointer_H);
LD_pBCp_H();
INC_BC();
LD_pBCp_L();

POP_DE();
POP_BC();
POP_AF();
POP_HL();

RET();