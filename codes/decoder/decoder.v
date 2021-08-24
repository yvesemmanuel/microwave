module decoder(unit_secs, ten_secs, minutes, unit_secs_segments, ten_secs_segments, minutes_segments);

  input wire [3:0] unit_secs, ten_secs, minutes;
  output wire [6:0] unit_secs_segments, ten_secs_segments, minutes_segments;
  
  assign unit_secs_segments = (unit_secs == 4'b0000) ? 7'b1111110: // 0
  			   (unit_secs == 4'b0001) ? 7'b0110000: // 1
                          (unit_secs == 4'b0010) ? 7'b1101101: // 2 
                          (unit_secs == 4'b0011) ? 7'b1111001: // 3
                          (unit_secs == 4'b0100) ? 7'b0110011: // 4
                          (unit_secs == 4'b0101) ? 7'b1011011: // 5
                          (unit_secs == 4'b0110) ? 7'b1011111: // 6
                          (unit_secs == 4'b0111) ? 7'b1110000: // 7
                          (unit_secs == 4'b1000) ? 7'b1111111: // 8
                          (unit_secs == 4'b1001) ? 7'b1110011: // 9
                          8'bXXXX_XXXX ;
                          
  assign ten_secs_segments = (ten_secs == 4'b0000) ? 7'b1111110: // 0 
                         (ten_secs == 4'b0001) ? 7'b0110000: // 1
                         (ten_secs == 4'b0010) ? 7'b1101101: // 2 
                         (ten_secs == 4'b0011) ? 7'b1111001: // 3
                         (ten_secs == 4'b0100) ? 7'b0110011: // 4
                         (ten_secs == 4'b0101) ? 7'b1011011: // 5
                         (ten_secs == 4'b0110) ? 7'b1011111: // 6
                         (ten_secs == 4'b0111) ? 7'b1110000: // 7
                         (ten_secs == 4'b1000) ? 7'b1111111: // 8
                         (ten_secs == 4'b1001) ? 7'b1110011: // 9
                         8'bXXXX_XXXX ;

  assign minutes_segments = (minutes == 4'b0000)? 7'b1111110: // 0 
                        (minutes == 4'b0001)? 7'b0110000: // 1
                        (minutes == 4'b0010)? 7'b1101101: // 2 
                        (minutes == 4'b0011)? 7'b1111001: // 3
                        (minutes == 4'b0100)? 7'b0110011: // 4
                        (minutes == 4'b0101)? 7'b1011011: // 5
                        (minutes == 4'b0110)? 7'b1011111: // 6
                        (minutes == 4'b0111)? 7'b1110000: // 7
                        (minutes == 4'b1000)? 7'b1111111: // 8
                        (minutes == 4'b1001)? 7'b1110011: // 9
                        8'bXXXX_XXXX ;
endmodule
