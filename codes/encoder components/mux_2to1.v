module mux_2to1(sel, in, in1, out);
  input wire in, in1, sel;
  output wire out;
  
  assign out = ((sel == 0) ? in : in1);
endmodule
