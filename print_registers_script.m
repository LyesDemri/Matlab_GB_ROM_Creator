print_registers = dec2hex(PC,4);
disp(['print registers subroutine: ', dec2hex(PC,4)]);
%first register to display is in register_address_H/L

PUSH_AF();
PUSH_BC();
PUSH_DE();
PUSH_HL();

%start writing at top left of screen
write_to_address('98',cursor_address_H);
write_to_address('00',cursor_address_L);
write_to_address('20',tiles_left);
write_to_address('12',lines_left);

LD_A('12');
LD_B('02');
loop1 = dec2hex(PC,4);
    loop2 = dec2hex(PC,4);
        CALL(print_register);
        LD_DE(register_address_H);CALL(increment_16bit_register); 
        CALL(skip_line);
        DEC_A();
    JP_NZ(loop2);
    write_to_address('98',cursor_address_H);
    write_to_address('0A',cursor_address_L);
    LD_A('12');
    DEC_B();
JP_NZ(loop1);

POP_HL();
POP_DE();
POP_BC();
POP_AF(); 

RET();