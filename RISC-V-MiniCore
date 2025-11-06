module riscv_core(
    input clk,
    input rst
);
    // Program Counter
    reg [31:0] pc;
    
    // Instruction Memory (simplified)
    reg [31:0] instr_mem [0:15];
    
    // Registers
    reg [31:0] regfile [0:31];
    
    // Data Memory
    reg [31:0] data_mem [0:15];
    
    // Instruction fields
    wire [6:0] opcode;
    wire [4:0] rd, rs1, rs2;
    wire [31:0] imm;
    
    reg [31:0] instr;
    reg [31:0] alu_out;
    
    // Fetch instruction
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 0;
        end else begin
            instr <= instr_mem[pc[3:0]]; // small memory
            pc <= pc + 1;
        end
    end
    
    // Decode (simplified, only R-type ADD/SUB)
    assign opcode = instr[6:0];
    assign rd = instr[11:7];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign imm = instr[31:20];
    
    // Execute (very simple ALU)
    always @(*) begin
        case(opcode)
            7'b0110011: begin // R-type
                case(instr[14:12]) // funct3
                    3'b000: alu_out = regfile[rs1] + regfile[rs2]; // ADD
                    3'b100: alu_out = regfile[rs1] ^ regfile[rs2]; // XOR
                    3'b110: alu_out = regfile[rs1] | regfile[rs2]; // OR
                    3'b111: alu_out = regfile[rs1] & regfile[rs2]; // AND
                    default: alu_out = 0;
                endcase
            end
            7'b0000011: alu_out = regfile[rs1] + imm; // LW
            7'b0100011: alu_out = regfile[rs1] + imm; // SW
            default: alu_out = 0;
        endcase
    end
    
    // Writeback
    always @(posedge clk) begin
        if (opcode == 7'b0110011) begin
            regfile[rd] <= alu_out;
        end else if (opcode == 7'b0000011) begin
            regfile[rd] <= data_mem[alu_out[3:0]];
        end else if (opcode == 7'b0100011) begin
            data_mem[alu_out[3:0]] <= regfile[rs2];
        end
    end

endmodule
