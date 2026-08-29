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
  cla4 U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  // ---- Option 3: dataflow carry-lookahead adder ----
  // cla4_dataflow U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

endmodule

// (b) Gate-level CLA reflection
// ------------------------------------------------------------

// Would this hand-instantiated, gate-by-gate approach still be
// reasonable for a 64-bit CLA?
//
// No. It would become very large and difficult to write,
// verify, maintain, and debug by hand.
//
// A 64-bit CLA has much more complicated direct carry equations,
// because the final carry would contain increasingly long
// propagate terms.
//
// In a single fully expanded 64-bit CLA, the term feeding the
// final carry corresponding to the input carry would be:
//
// p63 & p62 & p61 & ... & p1 & p0 & cin
//
// That term contains:
//
// 64 literals
//
// i.e. 63 propagate signals plus cin.
//
// Therefore, a fully expanded 64-bit CLA is impractical to
// hand-instantiate gate-by-gate. In practice, hierarchical or
// block-based CLA structures are used instead.