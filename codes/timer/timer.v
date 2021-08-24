module timer(load, clk, clear, en, input_signal, sec_ones, sec_tens, mins, zero);
  
  // variables declaration
  input wire load, clk, clear, en;
  input wire [3:0] input_signal;
  output wire [3:0] sec_ones, sec_tens, mins;
  output wire zero;
  wire en_units_secs, en_tens_secs, en_minutes;
  wire zero_sec, zero_ten_units_secs, zero_min;
  
  // modules
  counter_4bit_mod10 unit_seconds_component(.load(load), .clk(clk), .clear(clear), .en(en), .input_signal(input_signal), .terminal_count(en_tens_secs), .zero(zero_sec), .data_out(sec_ones));
  
  counter_4bit_mod6 ten_secs_component(.load(load), .clk(clk), .clear(clear), .en(en_tens_secs), .input_signal(sec_ones), .terminal_count(en_minutes), .zero(zero_ten_units_secs), .data_out(sec_tens));
  
  counter_4bit_mod10 minutes_component(.load(load), .clk(clk), .clear(clear), .en(en_minutes), .input_signal(sec_tens), .terminal_count(en_units_secs), .zero(zero_min), .data_out(mins));
  
  and(zero, zero_sec, zero_ten_units_secs, zero_min);
  assign zero = zero_sec & zero_ten_units_secs && zero_min;

endmodule
