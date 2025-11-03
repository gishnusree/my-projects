module uart_rx (
    input  logic       clk,
    input  logic       reset,
    input  logic       rx,
    output logic [7:0] data_out,
    output logic       rx_done
);

    parameter CLK_PER_BIT = 10;
    typedef enum logic [2:0] {IDLE, START, DATA, STOP, DONE} state_t;
    state_t state;
    logic [3:0] bit_index;
    logic [15:0] clk_count;
    logic [7:0] rx_data;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            rx_done <= 0;
            bit_index <= 0;
            clk_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    rx_done <= 0;
                    if (~rx)
                        state <= START;
                end

                START: begin
                    if (clk_count == (CLK_PER_BIT/2)) begin
                        if (~rx) begin
                            clk_count <= 0;
                            state <= DATA;
                        end else
                            state <= IDLE;
                    end else
                        clk_count <= clk_count + 1;
                end

                DATA: begin
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        rx_data[bit_index] <= rx;
                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else begin
                            bit_index <= 0;
                            state <= STOP;
                        end
                    end
                end

                STOP: begin
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        rx_done <= 1;
                        data_out <= rx_data;
                        state <= IDLE;
                    end
                end
            endcase
        end
    end
endmodule
