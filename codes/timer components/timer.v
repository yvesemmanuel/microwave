module timer(input_signal, load, clk, clear, en, units_sec, tens_sec, minutes, zero);
  
  // variables declaration
  input wire load, clk, clear, en;
  input wire [3:0] input_signal;
  output wire [3:0] units_sec, tens_sec, minutes;
  output wire zero;
  wire en_units_sec, en_tens_sec, en_minutes;
  wire zero_units_sec, zero_tens_sec, zero_minute;
  
  // modules
  counter_4bit_mod10 units_second_component(.load(load), .clk(clk), .clear(clear), .en(en),
                                            .input_signal(input_signal), .output_signal(units_sec),
                                            .terminal_count(en_tens_sec), .zero(zero_units_sec));
  
  counter_4bit_mod6 tens_sec_component(.load(load), .clk(clk), .clear(clear), .en(en_tens_sec),
                                       .input_signal(units_sec), .output_signal(tens_sec),
                                       .terminal_count(en_minutes), .zero(zero_tens_sec));
  
  counter_4bit_mod10 minutes_component(.load(load), .clk(clk), .clear(clear), .en(en_minutes),
                                       .input_signal(tens_sec), .output_signal(minutes),
                                       .terminal_count(en_units_sec), .zero(zero_minute));
  
  and(zero, zero_units_sec, zero_tens_sec, zero_minute);
  assign zero = zero_units_sec & zero_tens_sec && zero_minute;

endmodule
