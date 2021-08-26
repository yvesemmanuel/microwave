module encoder(code, clk, en, D, pgt_1Hz, load);
  input wire [9:0] code;
  input wire clk, en;
  output wire [3:0] D;
  output wire pgt_1Hz, load;
  wire decoded, INmux, IN1mux;
  
  // modules
  keypad_coder penc(.keys(code), .en(en), .D(D), .number(decoded));
  debouncer deb(.clk(clk), .clear(decoded), .out(INmux));
  division div(.clk(clk), .clk_division(IN1mux));
  mux_2to1 mux(.in(INmux), .in1(IN1mux), .sel(en), .out(pgt_1Hz));
  
  assign load = decoded;
endmodule
