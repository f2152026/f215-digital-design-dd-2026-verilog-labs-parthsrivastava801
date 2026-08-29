// FA_Gate.v
// Gate-level model of a 1-bit full adder. No delays yet -- that starts in
// Task 2. This task is purely about gate ordering.
//
// Part (a): leave this file exactly as it is, compile, and simulate.
// Part (b): AFTER completing part (a), come back and reorder the five gate
//           instantiations below into any different sequence, then
//           re-simulate with the same tb.v and compare.

module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);
  wire ps, pc1, pc2;

  and #(2) (pc1, a,   b);
  xor #(2) (sum, cin, ps);
  or  #(2) (cout, pc1, pc2);
  and #(2) (pc2, cin, ps);
  xor #(2) (ps,  a,   b);

// Task 1(b):
// Reordering the gate instantiations does not change the waveform or output.
// This is because Verilog gate-level statements represent hardware components
// that execute concurrently (in parallel), not sequentially from top to bottom.
// Therefore, changing the order of the gate statements does not affect the
// functionality of the full adder.

// Task 1(c):
// Adding delays changes the waveform timing because signals now take time to
// propagate through each gate. The final values of sum and cout remain correct,
// but the output transitions occur after the specified gate delays.
// Thus, gate order does not affect the waveform, while gate delays affect
// the timing of the waveform.

endmodule
