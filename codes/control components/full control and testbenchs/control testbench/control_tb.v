`timescale 1ns/1ps
module control_tb();
  
  reg start, stop, clear , closed_door, finished_time;
  wire magnetron;

  control DUT(
    .start(start), .stop(stop), .clear(clear),
    .closed_door(closed_door), .finished_time(finished_time),
    .magnetron(magnetron)  
  );
  
  initial
    begin
      $dumpfile("testbench_control.vcd");
      $dumpvars(0, control_tb);

      start = 0; stop = 0; clear = 0; finished_time = 0; closed_door = 0;   

      #10 start = 1; stop = 1; clear = 0; finished_time = 0; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 0; finished_time = 0; closed_door = 1;   
      #10 start = 1; stop = 1; clear = 0; finished_time = 1; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 0; finished_time = 1; closed_door = 1;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 0; 
      #10 start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 1;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 1;   

      #10 start = 1; stop = 1; clear = 0; finished_time = 0; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 0; finished_time = 0; closed_door = 1;  
      #10 start = 1; stop = 1; clear = 0; finished_time = 1; closed_door = 0;  
      #10 start = 1; stop = 1; clear = 0; finished_time = 1; closed_door = 1;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 1;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 1;   

      #10 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 0;   
      #10 start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 0;   
      #10 start = 1; stop = 0; clear = 1; finished_time = 0; closed_door = 0;   
      #10 start = 1; stop = 0; clear = 1; finished_time = 0; closed_door = 0;   
      #10 start = 1; stop = 0; clear = 1; finished_time = 0; closed_door = 0;   

      #10 start=0; stop=1; clear=1; finished_time=0; closed_door=0;   
      #10 start=0; stop=1; clear=1; finished_time=0; closed_door=1;   
      #10 start=0; stop=1; clear=1; finished_time=1; closed_door=0;   
      #10 start=0; stop=1; clear=1; finished_time=1; closed_door=1;   
      #10 start=0; stop=1; clear=1; finished_time=0; closed_door=0;   
      #10 start=1; stop=1; clear=1; finished_time=0; closed_door=1;   
      #10 start=1; stop=1; clear=1; finished_time=1; closed_door=0;   
      #10 start=1; stop=1; clear=1; finished_time=1; closed_door=1;   

      #10 start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 1;   
      #50 start = 0; stop = 1; clear = 1; finished_time = 0; closed_door = 1;   
      #5  start = 1; stop = 1; clear = 1; finished_time = 0; closed_door = 1;   
      #50 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 1;   
      #50 start = 1; stop = 1; clear = 1; finished_time = 1; closed_door = 0;   
    end
endmodule
