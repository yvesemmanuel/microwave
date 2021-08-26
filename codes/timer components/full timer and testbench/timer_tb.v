`timescale 1us/1ps
module timer_tb();
  reg [3:0] input_signal;
  reg load, clear, clk, en;
  integer i;
  
  timer DUT(.input_signal(input_signal), .load(load), .clk(clk),
            .clear(clear), .en(en));

  initial
    begin
      $dumpfile("timer_tb.vcd");
      $dumpvars;
      
      for(i = 0; i < 3005; i++)
        begin
          #5000 clk <= ~clk;
        end
    end
  
  initial
    begin
      load = 0;
      clear = 0;
      clk = 1;
      en = 1;
      input_signal = 4'd5;
      
      #16000;
      load = 1;
      
      #100000;
      clear = 1;
      
      #8000;
      clear = 0;
    end
endmodule
