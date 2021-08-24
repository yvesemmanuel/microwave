module control(start , stop , clear, opened_door, finished_time, magnetron);

  input wire start , stop , clear, opened_door, finished_time;
  output wire magnetron;
  wire rS, rR, wire rQ;
  
  assign rS = (!start  && opened_door) ? 1 : 0;
  assign rR = (!stop || finished_time || !opened_door || !clear) ? 1 : 0;
  
  SR_latch LSR_on(.Q(rQ), .S(rS), .R(rR));
  assign magnetron = rQ;
endmodule
