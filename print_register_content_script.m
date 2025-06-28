print_register_content = dec2hex(PC,4);
disp(['print register_content subroutine: ', dec2hex(PC,4)]);

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

SWAP_A();
CALL(print_nibble)
SWAP_A();

CALL(print_nibble); 

POP_HL();
POP_DE();
POP_BC();
POP_AF();
RET();