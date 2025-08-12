`include "./counter.v"

parameter DIGITS = 3;

module top(
    input  logic clk,
    input  logic rst,
    output logic [DIGITS:0] f,
    output logic overflow
);
    counter#(DIGITS) my_counter (clk, rst, f, overflow);
endmodule
