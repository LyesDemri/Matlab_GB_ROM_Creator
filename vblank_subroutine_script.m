%Subroutine to wait for VBlank
wait_for_vblank = dec2hex(PC,4);
disp(['wait for vblank subroutine: ', dec2hex(PC,4)]);

PUSH_AF();
PUSH_HL();

%1/ Read LCD status
waitloop = PC;
    LD_HL('FF41')
    LD_A_pHLp();
    AND('03');
    SUB('01');
    %2/ if VBLANK has arrived, skip 3
    JR_Z('03')
    %3/ else, jump to 1
JP(dec2hex(waitloop));

POP_HL();
POP_AF();

RET();