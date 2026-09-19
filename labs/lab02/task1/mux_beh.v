// mux_beh.v
// 2-to-1 multiplexer, BEHAVIORAL style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in behavioral modeling.

module mux_beh (
  input       I0,
  input       I1,
  input       S,
  output reg Y
);

  always @(*) begin
    if (S)
      Y = I1;
    else
      Y = I0;
  end

endmodule


//Behavioral: Behavioral modeling uses procedural assignments inside an always block, so its output must be a variable (reg) that can store the value assigned procedurally.
// If the bug is left in: The simulator reports that the output is not a valid l-value because a wire cannot be assigned inside an always block, while a reg cannot be driven by a continuous assign statement.