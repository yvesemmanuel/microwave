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
