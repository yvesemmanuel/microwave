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
