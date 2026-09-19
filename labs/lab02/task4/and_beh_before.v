// and_beh_before.v

// Behavioral AND gate with a 1 time-unit delay before the assignment.
module and_beh_before (
    input  a,
    input  b,
    output reg y
);

    always @(*) begin
        #1 y = a & b;
    end

endmodule