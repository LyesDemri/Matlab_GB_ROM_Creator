disp(['handle up button code: ' dec2hex(PC,4)]);
BIT_2_B();  %if bit 2 of register B is 0
JP_NZ('0000');startif=PC;
    LD_HL(input_buffer_address)     %if bit 2 of C000 is 1
    BIT_2_pHLp();
    JP_Z('0000');startif2=PC;
        %if we're at bottom of screen:
        LD_HL(chr_Y);   %if chr_Y == 17
        LD_A_pHLp();
        CP(dec2hex(0));
        JR_NZ('00');startif3=PC;
            call_up_screen;
        JR('00'); else3 = PC;rom(startif3)=else3-startif3;
            %must check if tile above is empty
            %we must calculate its coordinates first.
            %its coordinates are the character's current coordinates - 20
            LD_HL(character_coordinates_H);LD_D_pHLp();
            LD_HL(character_coordinates_L);LD_E_pHLp();
            LD_HL('FFEC'); %2's complement of 0x0014
            ADD_HL_DE();    %HL = HL + DE (= DE - 0x0014)
            LD_D_H();LD_E_L();           
            %compare the contents of that address with 0
            LD_A_pDEp();
            CP('00');
            JR_NZ('00');startif4=PC;
                %if it's empty, move the character
                LD_HL(character_coordinates_H);LD_pHLp_D();
                LD_HL(character_coordinates_L);LD_pHLp_E();
                LD_HL(chr_Y_pixels);LD_A_pHLp();
                SUB('08');
                LD_pHLp_A();
                LD_HL(chr_Y);%(chr_Y)--;
                DEC_pHLp();
            endif4=PC;rom(startif4)=endif4-startif4;
        endif3=PC;rom(else3)=endif3-else3;
    endif2=dec2hex(PC,4);
    rom(startif2-1) = hex2dec(endif2(3:4));
    rom(startif2) = hex2dec(endif2(1:2));
endif = dec2hex(PC,4);
rom(startif-1) = hex2dec(endif(3:4));
rom(startif) = hex2dec(endif(1:2));
