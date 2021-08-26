module control(start , stop , clear, closed_door, finished_time, magnetron);

  input wire start, stop, clear, closed_door, finished_time;
  output wire magnetron;
  wire rs, rr, rq;
  
  assign rs = ((!start  && closed_door)) ? 1 : 0;
  assign rr = ((!stop || finished_time || !closed_door || !clear)) ? 1 : 0;
  
  SR_latch latch(.r(rr), .s(rs), .q(rq));
  assign magnetron = rq;
endmodule
