%Subroutine to load next note:
disp(['load next note subroutine: ', dec2hex(PC)]);
tempo_period = '03';

load_next_note = dec2hex(PC,4);

PUSH_AF();
PUSH_BC();
PUSH_HL();
PUSH_DE(); 

LD_HL(time_ctr_addr);   %time_ctr_addr--
DEC_pHLp();
JR_NZ('00'); startif=PC;    %if time_ctr_addr == 0
    LD_HL(time_ctr_addr);   %reset time counter
    LD_pHLp(tempo_period);
    LD_HL(ch1_index_address_H);LD_D_pHLp(); %DE = (C003, C004)
    LD_HL(ch1_index_address_L);LD_E_pHLp();
    LD_A_pDEp();LD_HL('FF11');LD_pHLp_A();INC_DE(); %(FF11) = (DE); DE++
    LD_A_pDEp();INC_HL();LD_pHLp_A();INC_DE();
    LD_A_pDEp();INC_HL();LD_pHLp_A();INC_DE();
    LD_A_pDEp();INC_HL();LD_pHLp_A();INC_DE();
    LD_HL(note_pointer_addr);INC_pHLp();
    LD_A_pHLp();
    CP('40');
    JR_NZ('00');startif2=PC;
            %we'd like to put a variable value here that depends on where
            %the data for music starts in the ROM. But we don't yet know
            %where it will be, so we take note of it here and as soon as we
            %know where the data will start, we will complete this LD_DE
            %statement.
            LD_DE('0000');  %placeholder value of 0x0000
            %these 2 variables will remember the value where the actual
            %value for DE will be stored.
            music_start_address_marker_L = PC-1;
            music_start_address_marker_H = PC;
            LD_HL(note_pointer_addr);LD_pHLp(0);
    endif2=PC;rom(startif2)=endif2-startif2;
    %(C003, C004) <- (DE)
    LD_HL(ch1_index_address_H);LD_pHLp_D();
    LD_HL(ch1_index_address_L);LD_pHLp_E();
endif = PC;rom(startif)=endif-startif;

POP_DE();
POP_HL();
POP_BC();
POP_AF();
RET();