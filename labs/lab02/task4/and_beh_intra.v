// and_beh_intra.v

// Behavioral AND gate with a 1 time-unit intra-assignment delay.
module and_beh_intra (
    input  a,
    input  b,
    output reg y
);

    always @(*) begin
        y = #1 a & b;
    end

endmodule