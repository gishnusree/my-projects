// counter.v — simple 4-bit synchronous counter
// Demonstrates clock, reset, and synthesizable logic
module counter (
    input  wire clk,      // clock
    input  wire rst_n,    // active-low reset
    output reg  [3:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'd0;      // reset to 0
        else
            count <= count + 1; // increment each clock
    end
endmodule
