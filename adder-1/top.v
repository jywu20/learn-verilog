`include "adder.v"

/* verilator lint_off UNUSED */

module top(
    input logic clk,
    input logic [2:0] a,
    input logic [2:0] b,
    output logic [2:0] c
);
    adder#(3) adder1 (a, b, c);
endmodule