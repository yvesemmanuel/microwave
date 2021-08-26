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
