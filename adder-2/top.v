`include "./counter.v"

parameter DIGITS = 3;

module top(
    input clk,
    input rst,
    output reg [DIGITS:0] f,
    output reg overflow
);
    counter#(DIGITS) my_counter (clk, rst, f, overflow);
endmodule