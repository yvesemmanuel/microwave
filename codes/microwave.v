module microwave(start, clear, stop, opened_door, keypad, clk, sec_ones_seg, sec_tens_seg, mins_seg, magnetron);

  input wire start, clear, stop, opened_door;
  input wire [9:0] keypad;
  input wire clk;
  output wire [6:0] sec_ones_seg, sec_tens_seg, mins_seg;
  output wire magnetron;


  wire mag_output;
  assign magnetron = mag_output;
  
  wire timer_load;
  wire timer_clk;
  wire [3:0] timer_output;
  wire timer_done;
  
  wire [3:0] sec_ones;
  wire [3:0] sec_tens;
  wire [3:0] min;
  
  encoder keyboard_encoder(.code(keypad), .clk(clk), .en(mag_output), .D(timer_output),
  	.pgt_1Hz(timer_clk), .load(timer_load));
  	
  timer main_timer(.load(timer_load), .clk(timer_clk), .clear(clear), .en(magnetron), .data_in(timer_output),
  .sec_ones(sec_ones), .sec_tens(sec_tens), .minutes(min), .zero(timer_done));
  	
  control main_control(.start(start), .stop(stop), .clear(clear) , .opened_door(opened_door),
  .timer_done(timer_done),   .magnetron(mag_output));
  	
  decoder decoder_display(.unit_secs(sec_ones), .ten_secs(sec_tens), .minutes(min), .unit_secs_segments(sec_ones_seg),
  	.ten_secs_segments(sec_tens_seg), .minutes_segments(mins_seg));

endmodule