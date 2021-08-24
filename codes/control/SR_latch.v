module SR_latch( output wire Q, input wire R, S);
  reg rQ = 0;
  assign Q = rQ; 

  always @(S,R)
    begin
      if(S && R || !S && !R)
        begin
          // condition to 
        end
      else if(!S && R) begin
            rQ = 0;
        end
        else if(S && !R) begin
            rQ = 1;
        end
    end
endmodule
