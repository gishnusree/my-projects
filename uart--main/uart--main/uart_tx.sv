module uart_tx (
    input  logic       clk,
    input  logic       reset,
    input  logic [7:0] data_in,
    input  logic       tx_start,
    output logic       tx,
    output logic       tx_done
);

    parameter CLK_PER_BIT = 10;
    typedef enum logic [2:0] {IDLE, START, DATA, STOP, DONE} state_t;
    state_t state;
    logic [3:0] bit_index;
    logic [7:0] tx_data;
    logic [15:0] clk_count;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            tx <= 1'b1;
            tx_done <= 0;
            bit_index <= 0;
            clk_count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    tx_done <= 0;
                    if (tx_start) begin
                        tx_data <= data_in;
                        state <= START;
                    end
                end

                START: begin
                    tx <= 1'b0;
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DATA;
                    end
                end

                DATA: begin
                    tx <= tx_data[bit_index];
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else begin
                            bit_index <= 0;
                            state <= STOP;
                        end
                    end
                end

                STOP: begin
                    tx <= 1'b1;
                    if (clk_count < CLK_PER_BIT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DONE;
                    end
                end

                DONE: begin
                    tx_done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
