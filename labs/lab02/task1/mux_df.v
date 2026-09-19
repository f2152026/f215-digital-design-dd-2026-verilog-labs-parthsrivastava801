// mux_df.v
// 2-to-1 multiplexer, DATAFLOW style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in dataflow modeling.

module mux_df (
  input      I0,
  input      I1,
  input      S,
  output wire Y
);

  assign Y = S ? I1 : I0;

endmodule

// Dataflow: Dataflow modeling uses a continuous assign statement, so its output must be a net (wire) that can be continuously driven by the assignment.
// If the bug is left in: The simulator reports that the output is not a valid l-value because a wire cannot be assigned inside an always block, while a reg cannot be driven by a continuous assign statement.
