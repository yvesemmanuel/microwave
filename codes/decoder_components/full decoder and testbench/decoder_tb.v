`timescale 1ns/1ps
module decoder_tb();
  reg [3:0] units_sec, tens_sec, minutes ;
  wire [6:0] minutes_segments , units_sec_segments , tens_sec_segments ;
  
  decoder DUT(
    .units_sec(units_sec), .tens_sec(tens_sec), .minutes(minutes),
    .units_sec_segments(units_sec_segments) , .tens_sec_segments(tens_sec_segments),
    .minutes_segments(minutes_segments)
  );
  initial
    begin
      $dumpfile("decoder_tb.vcd");
      $dumpvars(0, decoder_tb);
      
      units_sec = 0; tens_sec = 0; minutes = 0;
      
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 0;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 0; minutes = 1;
      #10 units_sec = 1; tens_sec = 0; minutes = 1;
      #10 units_sec = 1; tens_sec = 0; minutes = 1;
      
      #10 units_sec = 0; tens_sec = 1; minutes = 1;
      #10 units_sec = 0; tens_sec = 1; minutes = 1;
      #10 units_sec = 0; tens_sec = 1; minutes = 1;
      #10 units_sec = 0; tens_sec = 1; minutes = 1;
      #10 units_sec = 0; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      
      #10 units_sec = 1; tens_sec = 1; minutes = 1;
      #50 units_sec = 0; tens_sec = 1; minutes = 1;
      #5  units_sec = 1; tens_sec = 1; minutes = 1; 
      #50 units_sec = 1; tens_sec = 1; minutes = 1; 
      #50 units_sec = 1; tens_sec = 1; minutes = 1;  
    end
endmodule
