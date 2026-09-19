// and_df.v

// Dataflow AND gate with a 1 time-unit delay.
module and_df (
    input  a,
    input  b,
    output y
);

    assign #1 y = a & b;

endmodule