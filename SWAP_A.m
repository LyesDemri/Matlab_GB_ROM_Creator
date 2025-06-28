function SWAP_A()
  global PC;
  global rom;
  rom(PC+1)=hex2dec('CB');PC=PC+1;
  rom(PC+1)=hex2dec('37');PC=PC+1;