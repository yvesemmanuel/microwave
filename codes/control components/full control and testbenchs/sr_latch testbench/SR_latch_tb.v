`timescale 1ns/1ps
module SR_latch_tb();
  reg r, s;
  wire q;

  SR_latch DUT(.r(r), .s(s), .q(q));
  initial
    begin
      $dumpfile("testbench_srlatch.vcd");
      $dumpvars(0, SR_latch_tb);
      s = 0; r = 0;
      #10 s = 0; r = 0;
      #10 s = 0; r = 1;
      #10 s = 0; r = 1;
      #10 s = 1; r = 0;
      #10 s = 1; r = 0;
      #10 s = 0; r = 0;
      #10 s = 1; r = 0;
      #10 s = 1; r = 0;
      #10 s = 1; r = 0;
      #10 s = 1; r = 0;
      #10 s = 1; r = 0;
      #10 s = 0; r = 1;
      #10 s = 0; r = 1;
      #10 s = 0; r = 0;
      #10 s = 0; r = 0;
    end
endmodule
