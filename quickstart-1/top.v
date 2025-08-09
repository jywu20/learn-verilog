module top(
  input clk,
  input rst,
  output reg [9:0]f
);  

  always @(posedge clk) begin
    if (!rst)
      f <= 0;
    else
      f <= f+1;
  end

endmodule
