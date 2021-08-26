module keypad_coder(en, keys, D, number);
  input wire en;
  input wire [9:0] keys;
  output wire [3:0] D;
  output wire number;
  
  assign D = (keys & 512) ? 4'd9 :
             (keys & 256) ? 4'd8 :
             (keys & 128) ? 4'd7 :
             (keys & 64) ? 4'd6 :
             (keys & 32) ? 4'd5 :
             (keys & 16) ? 4'd4 :
             (keys & 8) ? 4'd3 :
             (keys & 4) ? 4'd2 :
             (keys & 2) ? 4'd1 :
             (keys & 1) ? 4'd0 : 4'd0;
  
  assign number = (keys == 10'b000000000);
endmodule
