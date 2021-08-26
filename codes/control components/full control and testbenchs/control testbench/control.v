module SR_latch(r, s, q);
  input wire r, s;
  output wire q;
  reg rq = 0;
  
  assign q = rq;
  
  always @(r, s)
    begin
      if(r && s || !r && !s)
        begin
          // condition to ignore
        end
      else if(r && !s)
        begin
          rq = 0;
        end
      else if(!r && s)
        begin
          rq = 1;
        end
    end
endmodule


module control(start , stop , clear, closed_door, finished_time, magnetron);

  input wire start, stop, clear, closed_door, finished_time;
  output wire magnetron;
  wire rs, rr, rq;
  
  assign rs = ((!start  && closed_door)) ? 1 : 0;
  assign rr = ((!stop || finished_time || !closed_door || !clear)) ? 1 : 0;
  
  SR_latch latch(.r(rr), .s(rs), .q(rq));
  assign magnetron = rq;
endmodule
