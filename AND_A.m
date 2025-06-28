function AND_A(value)
  global PC;
  global rom;
  rom(PC+1)=hex2dec('E6');PC=PC+1;
  rom(PC+1)=hex2dec(value);PC=PC+1;