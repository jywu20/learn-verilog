module top(
    input clk,
    input rst,
    output reg [2:0] f
);
    always_ff @(posedge clk) begin
        if (!rst) begin
            f <= 0;
        end else begin
            f <= f + 1;
        end
    end
endmodule
