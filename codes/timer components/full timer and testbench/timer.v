// it counts tens of seconds;
module counter_4bit_mod6(output_signal, terminal_count, zero, load, clk, clear, en, input_signal);

  // variables declaration
  input wire load, clk, clear, en;
  input wire [3:0] input_signal;
  output wire terminal_count, zero;
  output wire [3:0] output_signal;
  reg [3:0] current_state;
  
  assign output_signal = current_state;
  assign zero = ((current_state == 0)) ? 1 : 0;
  assign terminal_count = ((current_state == 0) & en) ? 1 : 0;
  
  always @(posedge clk)
    begin: counter
      
      if (en)
        begin
          if (current_state == 4'b0000)
            begin
              current_state <= 4'd5;
            end
          
          else
            begin
              current_state <= current_state - 1;
            end
        end
      
      	else
          begin
            if (!load)
              begin
                current_state <= input_signal;
              end
          end
    end
  
  always @(negedge clear)
    begin
      if (!clear)
        begin
          current_state <= 4'b0000;
        end
    end
endmodule


// it counts units of seconds;
module counter_4bit_mod10(output_signal, terminal_count, zero, load, clk, clear, en, input_signal);

  // variables declaration
  input wire load, clk, clear, en;
  input wire [3:0] input_signal;
  output wire terminal_count, zero;
  output wire [3:0] output_signal;
  reg [3:0] current_state;
  
  // output signals for controls
  assign output_signal = current_state;
  assign zero = ((current_state == 0)) ? 1 : 0;
  assign terminal_count = ((current_state == 0) & en) ? 1 : 0;
  
  always @(posedge clk)
    begin: counter
      
      if (en)
        begin
          if (current_state == 4'b0000)
            begin
              current_state <= 4'd9;
            end
          
          else
            begin
              current_state <= current_state - 1;
            end
        end
      
      	else
          begin
            if (!load)
              begin
                current_state <= input_signal;
              end
          end
    end
  
  always @(negedge clear)
    begin
      if (!clear)
        begin
          current_state <= 4'b0000;
        end
    end
endmodule


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
