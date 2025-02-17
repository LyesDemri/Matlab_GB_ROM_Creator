disp(['Handle right button: ' dec2hex(PC,4)])
BIT_0_B();  %if bit 0 of register B is 0
JP_NZ('0000');startif = PC; %jump longer than 255 so it's convoluted
    LD_HL(input_buffer_address)     %if bit 0 of C000 is 1
    BIT_0_pHLp();
    JR_Z('00');startif2=PC;
        %if we're at right edge of screen:
        LD_HL(chr_X);   %if chr_X == 19
        LD_A_pHLp();
        CP(dec2hex(19));
        JR_NZ('00');startif3=PC;
            call_right_screen;
        JR('00'); 
        else3 = PC;
        rom(startif3)=else3-startif3;
            %if tile to the right is empty
            LD_HL(character_coordinates_H);LD_D_pHLp();
            LD_HL(character_coordinates_L);LD_E_pHLp();
            %increase BC by 1 (to check if the content of this address is 0)
            INC_DE();
            %bring contents of (BC) to A
            LD_A_pDEp();
            CP('00');
            JR_NZ('00');startif4=PC;
                 %1/ update absolute coordinates
                LD_HL(character_coordinates_H);LD_pHLp_D();
                LD_HL(character_coordinates_L);LD_pHLp_E();
                %2/ move the character on screen:
                LD_HL(chr_X_pixels);
                LD_A_pHLp();
                ADD('08');
                LD_pHLp_A();
                %3/ increment chr_X
                LD_HL(chr_X);%(chr_X)++;
                INC_pHLp();
            endif4=PC;rom(startif4)=endif4-startif4;
        endif3=PC;rom(else3)=endif3-else3;
    endif2=PC;rom(startif2)=endif2-startif2;
endif = dec2hex(PC,4); 
rom(startif-1) = hex2dec(endif(3:4));
rom(startif) = hex2dec(endif(1:2));