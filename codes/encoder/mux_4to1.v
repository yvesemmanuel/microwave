module mux_4to1(in, in1, out, sel);
  input wire in, in1, sel;
  output wire out;
  
  assign out = ((sel == 0) ? in : in1);
endmodule
