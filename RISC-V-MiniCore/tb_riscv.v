`timescale 1ns/1ps
module tb_riscv;

    reg clk;
    reg rst;

    riscv_core uut(
        .clk(clk),
        .rst(rst)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #10;
        rst = 0;

        // Initialize instruction memory (manually)
        // Example: ADD x1, x2, x3
        uut.instr_mem[0] = 32'b0000000_00011_00010_000_00001_0110011; // ADD x1 = x2 + x3
        uut.instr_mem[1] = 32'b0000000_00001_00011_110_00010_0110011; // OR x2 = x3 | x1
        uut.instr_mem[2] = 32'b0000000_00010_00001_111_00011_0110011; // AND x3 = x1 & x2
        
        // Initialize registers
        uut.regfile[2] = 5; // x2
        uut.regfile[3] = 10; // x3

        #50; // run for some time
        $display("x1=%d, x2=%d, x3=%d", uut.regfile[1], uut.regfile[2], uut.regfile[3]);
        $finish;
    end

endmodule
