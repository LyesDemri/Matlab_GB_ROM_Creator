function INC_B()
  global PC;
  global rom;
  rom(PC+1)=hex2dec('04');PC=PC+1;