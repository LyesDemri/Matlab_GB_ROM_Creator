increment_16bit_register = dec2hex(PC,4);
disp(['increment 16 bit register function starts at: ' increment_16bit_register]);

%increments 16 bit register whose higher 8 
%bits are stored in DE

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

LD_H_D();
LD_L_E();
LD_B_pHLp();
INC_HL();
LD_C_pHLp();
INC_BC();
LD_H_D();
LD_L_E();
LD_pHLp_B();
INC_HL();
LD_pHLp_C();

POP_HL();
POP_DE();
POP_BC();
POP_AF(); 

RET();