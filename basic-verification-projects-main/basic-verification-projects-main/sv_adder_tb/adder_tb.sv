
`timescale 1ns/1ps

module adder_tb;
  logic [3:0] a, b;
  logic [4:0] sum, expected;

  adder dut (.a(a), .b(b), .sum(sum));

  initial begin
    $display("Starting 4-bit Adder Test...");
    repeat (10) begin
      a = $urandom_range(0, 15);
      b = $urandom_range(0, 15);
      expected = a + b;
      #1;
      if (sum !== expected)
        $error("FAIL: a=%0d b=%0d Expected=%0d Got=%0d", a, b, expected, sum);
      else
        $display("PASS: a=%0d b=%0d sum=%0d", a, b, sum);
    end
    $display("Test Completed.");
    $finish;
  end
endmodule
