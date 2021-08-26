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
  	
  timer main_timer(.load(timer_load), .clk(timer_clk), .clear(clear), .en(magnetron), .data_in(timer_output),
                   .units_sec(units_sec), .tens_sec(tens_sec), .minutesutes(minutes), .zero(timer_done));
  	
  control main_control(.start(start), .stop(stop), .clear(clear) , .closed_door(closed_door),
                       .finished_time(timer_done),   .magnetron(magnetron_output));
  	
  decoder decoder_display(.unit_secs(units_sec), .tens_sec(tens_sec), .minutes(minutes), .units_sec_segments(units_sec_segments),
                          .tens_sec_segments(tens_sec_segments), .minutes_segments(minutes_segments));

endmodule
