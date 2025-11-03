module uart_tb;
    logic clk = 0, reset = 0, tx_start;
    logic [7:0] data_in;
    logic [7:0] data_out;
    logic tx, rx_done;

    uart_top uut (
        .clk(clk),
        .reset(reset),
        .tx_start(tx_start),
        .data_in(data_in),
        .tx(tx),
        .data_out(data_out),
        .rx_done(rx_done)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("uart_wave.vcd");
        $dumpvars(0, uart_tb);

        reset = 1; #10; reset = 0;

        data_in = 8'hA5;  // test byte
        tx_start = 1; #10; tx_start = 0;

        wait(rx_done);
        $display("Received Data: %h", data_out);
        #50 $finish;
    end
endmodule
