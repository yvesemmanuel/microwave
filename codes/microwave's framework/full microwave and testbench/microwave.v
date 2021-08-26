module SR_latch(r, s, q);
  input wire r, s;
  output wire q;
  reg rq = 0;
  
  assign q = rq;
  
  always @(r, s)
    begin
      if(r && s || !r && !s)
        begin
          // condition to ignore
        end
      else if(r && !s)
        begin
          rq = 0;
        end
      else if(!r && s)
        begin
          rq = 1;
        end
    end
endmodule


module mux_2to1(sel, in, in1, out);
  input wire in, in1, sel;
  output wire out;
  
  assign out = ((sel == 0) ? in : in1);
endmodule


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


module division(clk, clk_division);
  input wire clk;
  output wire clk_division;
  
  reg [6:0] count = 0;
  reg tenth = 0;
  
  assign clk_division = tenth;

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
  division div(.clk(clk), .clk_division(IN1mux));
  mux_2to1 mux(.in(INmux), .in1(IN1mux), .sel(en), .out(pgt_1Hz));
  
  assign load = decoded;
endmodule

module decoder(units_sec, tens_sec, minutes, units_sec_segments, tens_sec_segments, minutes_segments);

  input wire [3:0] units_sec, tens_sec, minutes;
  output wire [6:0] units_sec_segments, tens_sec_segments, minutes_segments;
  
  assign units_sec_segments = (units_sec == 4'b0000) ? 7'b1111110: // 0
                              (units_sec == 4'b0001) ? 7'b0110000: // 1
                              (units_sec == 4'b0010) ? 7'b1101101: // 2 
                              (units_sec == 4'b0011) ? 7'b1111001: // 3
                              (units_sec == 4'b0100) ? 7'b0110011: // 4
                              (units_sec == 4'b0101) ? 7'b1011011: // 5
                              (units_sec == 4'b0110) ? 7'b1011111: // 6
                              (units_sec == 4'b0111) ? 7'b1110000: // 7
                              (units_sec == 4'b1000) ? 7'b1111111: // 8
                              (units_sec == 4'b1001) ? 7'b1110011: // 9
                              8'bXXXX_XXXX;
  
  assign tens_sec_segments = (tens_sec == 4'b0000) ? 7'b1111110: // 0 ->
                             (tens_sec == 4'b0001) ? 7'b0110000: // 1 ->
                             (tens_sec == 4'b0010) ? 7'b1101101: // 2 ->
                             (tens_sec == 4'b0011) ? 7'b1111001: // 3 ->
                             (tens_sec == 4'b0100) ? 7'b0110011: // 4 ->
                             (tens_sec == 4'b0101) ? 7'b1011011: // 5 ->
                             (tens_sec == 4'b0110) ? 7'b1011111: // 6 ->
                             (tens_sec == 4'b0111) ? 7'b1110000: // 7 ->
                             (tens_sec == 4'b1000) ? 7'b1111111: // 8 ->
                             (tens_sec == 4'b1001) ? 7'b1110011: // 9 ->
                             8'bXXXX_XXXX;

  assign minutes_segments = (minutes == 4'b0000) ? 7'b1111110: // 0 ->
                            (minutes == 4'b0001) ? 7'b0110000: // 1 ->
                            (minutes == 4'b0010) ? 7'b1101101: // 2 ->
                            (minutes == 4'b0011) ? 7'b1111001: // 3 ->
                            (minutes == 4'b0100) ? 7'b0110011: // 4 ->
                            (minutes == 4'b0101) ? 7'b1011011: // 5 ->
                            (minutes == 4'b0110) ? 7'b1011111: // 6 ->
                            (minutes == 4'b0111) ? 7'b1110000: // 7 ->
                            (minutes == 4'b1000) ? 7'b1111111: // 8 ->
                            (minutes == 4'b1001) ? 7'b1110011: // 9 ->
                            8'bXXXX_XXXX;
endmodule


module control(start , stop , clear, closed_door, finished_time, magnetron);

  input wire start, stop, clear, closed_door, finished_time;
  output wire magnetron;
  wire rs, rr, rq;
  
  assign rs = ((!start  && closed_door)) ? 1 : 0;
  assign rr = ((!stop || finished_time || !closed_door || !clear)) ? 1 : 0;
  
  SR_latch latch(.r(rr), .s(rs), .q(rq));
  assign magnetron = rq;
endmodule


module microwave(start, clear, stop, closed_door, keys, clk, units_sec_segments, tens_sec_segments, minutes_segments, magnetron);

  input wire start, clear, stop, closed_door;
  input wire [9:0] keys;
  input wire clk;
  output wire [6:0] units_sec_segments, tens_sec_segments, minutes_segments;
  output wire magnetron;


  wire magnetron_output;
  assign magnetron = magnetron_output;
  
  wire timer_load;
  wire timer_clk;
  wire [3:0] timer_output;
  wire timer_done;
  
  wire [3:0] units_sec;
  wire [3:0] tens_sec;
  wire [3:0] minutes;
  
  encoder keyboard_encoder(.code(keys), .clk(clk), .en(magnetron_output), .D(timer_output),
                           .pgt_1Hz(timer_clk), .load(timer_load));
  	
  timer main_timer(.load(timer_load), .clk(timer_clk), .clear(clear), .en(magnetron), .input_signal(timer_output),
                   .units_sec(units_sec), .tens_sec(tens_sec), .minutes(minutes), .zero(timer_done));
  	
  control main_control(.start(start), .stop(stop), .clear(clear) , .closed_door(closed_door),
                       .finished_time(timer_done),   .magnetron(magnetron_output));
  	
  decoder decoder_display(.units_sec(units_sec), .tens_sec(tens_sec), .minutes(minutes), .units_sec_segments(units_sec_segments),
                          .tens_sec_segments(tens_sec_segments), .minutes_segments(minutes_segments));

endmodule
