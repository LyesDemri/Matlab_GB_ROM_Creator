disp(['handle left button code: ' dec2hex(PC,4)]);
BIT_1_B();  %if bit 1 of register B is 0
JP_NZ('0000');startif = PC; %jump longer than 255 so it's convoluted
    LD_HL(input_buffer_address)     %if bit 1 of C000 is 1
    BIT_1_pHLp();
    JP_Z('0000');startif2=PC;
        %if we're at right edge of screen:
        LD_HL(chr_X);   %if chr_X == 0
        LD_A_pHLp();
        CP(dec2hex(0));
        JR_NZ('00');startif3=PC;
            call_left_screen;
        JR('00'); else3 = PC;rom(startif3)=else3-startif3;
            %if tile to the left is empty
            LD_HL(character_coordinates_H);LD_D_pHLp();
            LD_HL(character_coordinates_L);LD_E_pHLp();
            %increase BC by 1 (to check if the content of this address is 0)
            DEC_DE();
            %bring contents of (BC) to A
            LD_A_pDEp();
            CP('00');
            JR_NZ('00');startif4=PC;
                %then move
                LD_HL(character_coordinates_H);LD_pHLp_D();
                LD_HL(character_coordinates_L);LD_pHLp_E();
                LD_HL(chr_X_pixels);%(FE01) -= 8;
                LD_A_pHLp();
                SUB('08');
                LD_pHLp_A();
                LD_HL(chr_X);%(chr_X)--;
                DEC_pHLp();
            endif4=PC;rom(startif4)=endif4-startif4;
        endif3=PC;rom(else3)=endif3-else3;
    endif2=dec2hex(PC,4);
    rom(startif2-1) = hex2dec(endif2(3:4));
    rom(startif2) = hex2dec(endif2(1:2));
endif = dec2hex(PC,4);
rom(startif-1) = hex2dec(endif(3:4));
rom(startif) = hex2dec(endif(1:2));