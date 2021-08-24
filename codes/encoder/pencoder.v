module pencoder(enable, numbers, D, output_signal);
  input wire enable;
  input wire [9:0] numbers;
  output wire [3:0] D;
  output wire output_signal;
  
  assign D = (numbers & 512) ? 4'd9 :
             (numbers & 256) ? 4'd8 :
             (numbers & 128) ? 4'd7 :
             (numbers & 64) ? 4'd6 :
             (numbers & 32) ? 4'd5 :
             (numbers & 16) ? 4'd4 :
             (numbers & 8) ? 4'd3 :
             (numbers & 4) ? 4'd2 :
             (numbers & 2) ? 4'd1 :
             (numbers & 1) ? 4'd0 : 4'd0;
  
  assign output_signal = (numbers == 10'b000000000);
    
endmodule
