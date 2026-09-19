// tb.v

module tb;

  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  reg        exp_gt;
  reg        exp_lt;
  reg        exp_eq;

  integer errors;
  integer total;
  integer i;
  integer j;

  comp2 DUT (
    .A(t_a),
    .B(t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  initial begin
    errors = 0;
    total = 0;

    $monitor("time=%0t: A=%b B=%b GT=%b LT=%b EQ=%b",
             $time, t_a, t_b, t_gt, t_lt, t_eq);

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;

        exp_gt = (i > j);
        exp_lt = (i < j);
        exp_eq = (i == j);

        #1;

        total = total + 1;

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq,
                   exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("SUMMARY: %0d passed out of %0d total", total - errors, total);
    $display(" (%0d errors)", errors);

    $finish;
  end

endmodule