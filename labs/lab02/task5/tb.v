`timescale 1ns/1ps

module tb;
  reg  [3:0] a;
  reg  [3:0] b;
  reg        op;
  wire [3:0] result;

  integer i, j, k;
  integer errors;
  reg [3:0] expected;

  alu dut (
    .a(a),
    .b(b),
    .op(op),
    .result(result)
  );

  task check;
    input [3:0] va;
    input [3:0] vb;
    input        vop;
    begin
      a  = va;
      b  = vb;
      op = vop;
      #1;

      if (vop == 1'b0)
        expected = va + vb;
      else
        expected = va - vb;

      if (result !== expected) begin
        $display("FAIL: a=%0d b=%0d op=%b expected=%0d got=%0d",
                 va, vb, vop, expected, result);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    errors = 0;

    // Same operands, switch only op. This catches a missing op
    // from the combinational sensitivity list.
    check(4'd7, 4'd3, 1'b0);
    check(4'd7, 4'd3, 1'b1);
    check(4'd7, 4'd3, 1'b0);
    check(4'd7, 4'd3, 1'b1);

    // Test every 4-bit operand pair for both operations.
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin
          check(i, j, k);
        end
      end
    end

    if (errors == 0)
      $display("PASS: all ALU tests passed.");
    else
      $display("FAIL: %0d test(s) failed.", errors);

    $finish;
  end
endmodule
