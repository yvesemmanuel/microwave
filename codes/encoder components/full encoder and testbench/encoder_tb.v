`timescale 1us/1ps
module encoder_tb();
  reg [9:0] code;
  reg clk, en, in, in1;
  integer i;
  
  encoder DUT(.code(code), .clk(clk), .en(en));
  mux_2to1 DUT2(.sel(clk), .in(in), .in1(in1));
  initial
    begin
      $dumpfile("encoder_tb.vcd");
      $dumpvars;
      
      clk = 1;
      en = 0;
      code = 9'b000000000;
      
      for(i = 0; i < 3005; i++)
        begin
          #5000 clk <= ~clk;
        end
      
      #10;
    end
  
  initial
    begin
      #1000 code = 0;
      #100000 code = 1;
      #200000 code = 0;
      
      #120000 code = 1;
      #1000 code = 0;
      #3000 code = 1;
      #5000 code = 0;
      #2000 code = 1;
      #8000 code = 0;
      #9000 code = 1;
      
      #500000 code = 0;
      en = 1;
      
      #10000000;
    end
  
  initial
    begin
      in = 0;
      in1 = 0;
      
      #1000 in = 0;
      #1000 in1 = 0;
      
      #1000 in = 0;
      #1000 in1 = 1;
      
      #1000 in = 1;
      #1000 in1 = 0;
      
      #1000 in = 1;
      #1000 in1 = 1;
      
      #100;
    end
endmodule
