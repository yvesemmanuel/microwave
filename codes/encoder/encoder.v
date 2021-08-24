module encoder(code, clk, en, D, pgt_1Hz, load);
  input wire [9:0] code;
  input wire clk, en;
  output wire [3:0] D;
  output wire pgt_1Hz, load;
  wire decoded, INmux, IN1mux;
  
  pencoder penc(.codepad(code), .en(en), .D(D), .all_off(decoded));
  debouncer deb(.clk(clk), .clear(decoded), .out(INmux));
  division div(.clk(clk), .clk_div(IN1mux));
  
  mux_2to1 mux(.a(INmux), .b(IN1mux), .sel(en), .out(pgt_1Hz));
  
  assign load = decoded;
endmodule
