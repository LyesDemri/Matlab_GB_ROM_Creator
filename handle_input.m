disp(['handle input script: ' dec2hex(PC,4)]);
%start by inverting B
LD_A_B     %1
CPL()      %1
LD_B_A()   %1
LD_C('01');
controls_loop = dec2hex(PC,4);
	LD_A_C();		%A = FE, F
	AND_A_B();		%A = 0, 1, 2, 4, or 8
	CP_A_C();		%Z = 0 or 1
	JP_NZ('0000');startif = PC; 		%jump longer than 255 so it's convoluted
		LD_HL(input_buffer_address)     %if bit 1 of C000 is 1
		LD_A_C();		%A = 1, 2, 4, or 8
		AND_A_pHLp();	%A = 0, 1, 2, 4, or 8
		CP_A_C();		%Z = 0 or 1
		JP_Z('0000');startif2=PC;
			%if we're at right edge of screen:
			LD_HL(chr_X);   %if chr_X == 0
			LD_A(0);
			CP_pHLp();
			JR_NZ('00');startif3=PC;
                PUSH_BC(); %we need it for controls
                LD_HL('0155');PUSH_HL();        %6/ value to add to character coordinates
                LD_HL(dec2hex(360,4));PUSH_HL();%5/ value to add to current map address
                LD_A('88');PUSH_AF();           %4/ new value for chr_XY_pixels
                LD_HL(chr_Y_pixels);PUSH_HL();  %3/ address of chr_XY_pixels
                LD_HL(chr_Y);PUSH_HL();         %2/ address of chr_Y or chr_X
                LD_A(dec2hex(17));PUSH_AF();    %1/ new value of chr_Y/chr_X
                CALL(load_next_screen);
				
                %call_next_screen;
			JR('00'); else3 = PC;rom(startif3)=else3-startif3;
                NOP();  %move in correct direction
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

	RLC_C();
	LD_A('10');
	CP_A_C();
JP_NZ(controls_loop);