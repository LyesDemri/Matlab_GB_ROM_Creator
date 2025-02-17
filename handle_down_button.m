disp(['handle down button code: ' dec2hex(PC,4)]);
BIT_3_B();  %if bit 1 of register B is 0
JP_NZ('0000');startif=PC;
    LD_HL(input_buffer_address)     %if bit 1 of C000 is 1
    BIT_3_pHLp();
    JP_Z('0000');startif2=PC;    
        %if we're at bottom of screen:
        LD_HL(chr_Y);   %if chr_Y == 17
        LD_A_pHLp();
        CP(dec2hex(17));
        JR_NZ('00');startif3=PC;
            call_down_screen;
        JR('00'); else3 = PC;rom(startif3)=else3-startif3;
            %if tile underneath is empty
            LD_HL(character_coordinates_H);LD_D_pHLp(); %DE = character_coordinates
            LD_HL(character_coordinates_L);LD_E_pHLp();
            LD_HL('0014');  %HL = 0x14
            ADD_HL_DE();    %HL = HL + DE
            LD_D_H();LD_E_L();
            %bring contents of (DE) to A
            LD_A_pDEp();
            CP('00');
            JR_NZ('00');startif4=PC;
                %then move
                LD_HL(character_coordinates_H);LD_pHLp_D();
                LD_HL(character_coordinates_L);LD_pHLp_E();
                LD_HL(chr_Y_pixels);
                LD_A_pHLp();
                ADD('08');
                LD_pHLp_A();
                LD_HL(chr_Y);INC_pHLp();%(chr_Y)++;
            endif4=PC;rom(startif4)=endif4-startif4;
        endif3=PC;rom(else3)=endif3-else3;
    endif2=dec2hex(PC,4);
    rom(startif2-1) = hex2dec(endif2(3:4));
    rom(startif2) = hex2dec(endif2(1:2));
endif = dec2hex(PC,4);
rom(startif-1) = hex2dec(endif(3:4));
rom(startif) = hex2dec(endif(1:2));