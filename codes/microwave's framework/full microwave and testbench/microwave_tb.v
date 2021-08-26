`timescale 1ns/1ps
module microwave_tb();
  reg [9:0] key;
  reg clk, closed_door, stop, clear, start;
  wire [6:0] units_sec_segments, tens_sec_segments, minutes_segments;
  wire magnetron;
  integer i;

  microwave DUT(.start(start), .clear(clear), .stop(stop), .closed_door(closed_door),
                .keys(key), .clk(clk), .units_sec_segments(units_sec_segments),
                .tens_sec_segments(tens_sec_segments), .minutes_segments(minutes_segments), .magnetron(magnetron)); 
  
  
  initial
    begin
      $dumpfile("testbench.vcd");
      $dumpvars;
      clk = 1;
      
      for(i = 0; i < 700005; i++)
        begin
          #5000 clk <= ~clk;
        end
    end
        
  initial
    begin
    
    // first microwave test -> run it for 3 minutes and 59 secs so I can get my coffee as hot as I am!
    
      key = 9'b000000000;
      closed_door = 0;
      stop = 1;
      clear = 1;
      start = 1;

      // typing 1
      #120000;
      key = 9'b000000010;
      #110000;
      key = 9'b000000000;

      // typing 1 again
      #110000;
      key = 9'b000100000;
      #110000;
      key = 9'b000000000;

      // typing 0
      #110000;
      key = 10'b0000000001;
      #110000;
      key = 9'b000000000;
      
      // try to start the microwave
      #110000;
      start = 0;
      #110000;
      start = 1;
      #510000;
      
      // it won't work until the door is closed!
      closed_door = 1;
      #100000;
      start = 0;
      #100000;
      start = 1;
      #300000000;
    // end of first microwave test
        
    
    // second microwave test -> run it for 2 minutes  and 45 secs, but I don't know if that is enough, so look at the food 30 secs after turning the microwave on!
      
      key = 9'b000000000;
      closed_door = 1;
      stop = 1;
      clear = 1;
      start = 1;

      // typing 2
      #120000;
      key = 9'b000000100;
      #110000;
      key = 9'b000000000;

      // typing 4
      #110000;
      key = 9'b000010000;
      #110000;
      key = 9'b000000000;
      
      // typing 5
      #110000;
      key = 10'b0000100000;
      #110000;
      key = 9'b000000000;
      
      #110000;
      start = 0;
      #100000;
      start = 1;
      #3000000;
      
      // opening microwave's door to make sure it's enough time
      closed_door = 0;
      #810000;
      start = 0;
      #100000;
      start = 1;
      #100000;
      // oh, it isn't enough... run it again!
      closed_door = 1;
      #100000;
      start = 0;
      #100000;
      start = 1;
      #300000000;
    // end of second microwave test
    
      end
endmodule
