module adder #(
    parameter DIGITS = 4
) (
    input logic [DIGITS - 1 : 0] a,
    input logic [DIGITS - 1 : 0] b,
    output logic [DIGITS - 1 : 0] c
);
    // The split_var directive is needed here 
    // because the variable carrier appears on both sides of the 
    // continuous assignments below.
    // This doesn't cause any real problem,
    // because carrier has indices and carrier[i] never appears on 
    // both sides of a single assignment,
    // but still by default Verilator consideres this to be 
    // a dangerous coding style.
    logic carries[DIGITS - 1 : 0] /* verilator split_var */;
    assign carries[0] = a[0] && b[0];
    assign c[0] = a[0] ^ b[0];

    genvar i;
    generate for (i = 1; i < DIGITS; ++i) begin
        assign carries[i] = (a[i] && b[i]) || (a[i] && carries[i - 1]) || (b[i] && carries[i - 1]);
        assign c[i] = (~a[i] && b[i] && ~carries[i - 1]) || (~a[i] && ~b[i] && carries[i - 1]) || (a[i] && ~b[i] && ~carries[i - 1]) || (a[i] && b[i] && carries[i - 1]);
    end
    endgenerate
endmodule