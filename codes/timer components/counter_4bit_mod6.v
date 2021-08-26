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
