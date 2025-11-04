`timescale 1ns/1ps
module tb_counter;
    reg clk = 0;
    reg rst_n = 0;
    wire [3:0] count;

    // Instantiate the counter
    counter uut (.clk(clk), .rst_n(rst_n), .count(count));

    // Clock generator: 10ns period
    always #5 clk = ~clk;

    initial begin
        // Setup waveform dump
        $dumpfile("counter_wave.vcd");   // Name of the waveform file
        $dumpvars(0, tb_counter);        // Dump all signals in this module

        $display("Time\tReset\tCount");
        $monitor("%0t\t%b\t%b", $time, rst_n, count);

        // Apply reset
        #10 rst_n = 1;   // Release reset after 10ns

        // Run simulation for 100 ns
        #100;
        $finish;         // Finish simulation and write waveform
    end
endmodule
