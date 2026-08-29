// dut.v
// Wrapper module: pick exactly ONE of the three implementations below by
// leaving it uncommented, with the other two commented out. Compile and
// run tb.v, then switch to a different implementation and repeat -- this
// lets you compare rca.v, cla4.v, and cla4_dataflow.v using the exact same
// testbench and stimulus each time.

module dut(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  // ---- Option 1: delayed ripple-carry adder ----
  //rca U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  // ---- Option 2: gate-level carry-lookahead adder ----
  //cla4 U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  // ---- Option 3: dataflow carry-lookahead adder ----
  cla4_dataflow U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

endmodule

// (c) cla4.v vs cla4_dataflow.v:
//
// cla4.v uses explicit AND/OR gate primitives and intermediate wires,
// so it is longer and more verbose.
//
// cla4_dataflow.v uses assign statements, so each statement maps
// more directly to the Boolean equation being implemented.
//
// Example:
//
// assign #(2) c2 = g[1]
//                | (p[1] & g[0])
//                | (p[1] & p[0] & cin);
//
// is much easier to read than the equivalent collection of AND and
// OR gate instances.
//
// I would prefer cla4_dataflow.v for maintenance and debugging six
// months from now because it is shorter, clearer, and closer to the
// Boolean equations.


// (All three) Timing comparison:
//
// Based on the same testbench and the measured final transitions:
//
// RCA            -> slowest
// Gate-level CLA -> faster
// Dataflow CLA   -> fastest
//
// The RCA has a ripple carry path through multiple full adders.
// The CLA computes carries directly from the P/G equations, so the
// carry does not have to ripple through all four full adders.
//
// In these simulations, the dataflow CLA settles slightly earlier
// than the gate-level CLA because the Boolean equations are expressed
// directly in delayed assign statements.
//
// Exact waveform transitions depend on the simulator's handling of
// the individual gate/continuous-assignment delays, so the final
// stable value—not temporary intermediate values—is what should be
// used when comparing settling time.