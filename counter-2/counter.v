/* verilator lint_off VARHIDDEN */

module counter #(
    parameter DIGITS = 4
) (
    input logic clk,
    input logic rst,
    // In this example we use a rather small register as the counter,
    // and see how overflow happens.
    output logic [DIGITS:0] f,
    // Note that this variable'initial value can't be specified here.
    // In simulation we can alternate this value.
    output logic overflow
);
    always_ff @(posedge clk) begin
        if (!rst) begin
            f <= 0; 
        end else if (f == 2**DIGITS - 1) begin
            overflow <= 1;
        end else begin
            overflow <= 0;
            f <= f + 1;
        end
    end
endmodule
