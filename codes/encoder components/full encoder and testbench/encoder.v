module mux_2to1(sel, in, in1, out);
  input wire in, in1, sel;
  output wire out;
  
  assign out = ((sel == 0) ? in : in1);
endmodule


module debouncer(clk, clear, out);

  input wire clk, clear;
  output reg out = 0;

  reg [2:0] count = 3'd0;
  reg counting = 0;
  
  always @ (posedge clear)
    begin
      if (count == 3'd7)
        begin
          counting = 0;
          count = 3'd0;
          out = 0;
        end
    end
  
  always @ (negedge clear)
    begin
      if (count == 3'd0)
        begin
          counting = 1;
        end
    end
  
  always @ (posedge clk)
    begin
      if (count < 3'd7 && counting == 1)
        begin
          count <= count + 1;
    end
      
      if(count == 3'd3)
        begin
          out <= 1;
        end
    end
endmodule


module count_freq(clk, clk_count_freq);
  input wire clk;
  output wire clk_count_freq;
  
  reg [6:0] count = 0;
  reg tenth = 0;
  
  assign clk_count_freq = tenth;

    always @ (posedge clk)
      begin
        count <= count + 1;
        
        if (count == 7'd99)
          begin
            tenth <= 1;
            count <= 0;
          end
        else
          begin
            tenth <= 0;
          end
      end
    
endmodule


module keypad_coder(en, keys, D, number);
  input wire en;
  input wire [9:0] keys;
  output wire [3:0] D;
  output wire number;
  
  assign D = (keys & 512) ? 4'd9 :
             (keys & 256) ? 4'd8 :
             (keys & 128) ? 4'd7 :
             (keys & 64) ? 4'd6 :
             (keys & 32) ? 4'd5 :
             (keys & 16) ? 4'd4 :
             (keys & 8) ? 4'd3 :
             (keys & 4) ? 4'd2 :
             (keys & 2) ? 4'd1 :
             (keys & 1) ? 4'd0 : 4'd0;
  
  assign number = (keys == 10'b000000000);
endmodule


module encoder(code, clk, en, D, pgt_1Hz, load);
  input wire [9:0] code;
  input wire clk, en;
  output wire [3:0] D;
  output wire pgt_1Hz, load;
  wire decoded, INmux, IN1mux;
  
  // modules
  keypad_coder penc(.keys(code), .en(en), .D(D), .number(decoded));
  debouncer deb(.clk(clk), .clear(decoded), .out(INmux));
  count_freq div(.clk(clk), .clk_count_freq(IN1mux));
  mux_2to1 mux(.in(INmux), .in1(IN1mux), .sel(en), .out(pgt_1Hz));
  
  assign load = decoded;
endmodule
