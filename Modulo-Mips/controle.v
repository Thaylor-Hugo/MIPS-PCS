module controle #(
    parameter TIPO_R = 3'b0,
    parameter ADDI = 3'b1,
    parameter SLTI = 3'b10,
    parameter LW = 3'b11,
    parameter SW = 3'b100,
    parameter BEQ = 3'b101,
    parameter J = 3'b110,
    parameter JAL = 3'b111
) (
    input [2:0] opcode,
    input reset,
    output reg [1:0] ula_opcode, reg_dest, mem_to_reg,
    output reg ula_src, mem_escrita, mem_leitura, reg_escrita, branch, jump, sign_zero
);
    /* Determina as variaveis de controle das istrucoes, baseado no opcode da mesma */

    always @(*) begin
        if (reset) begin
            ula_opcode = 2'b0;
            reg_dest = 2'b0;
            mem_to_reg = 2'b0;
            ula_src = 1'b0;
            mem_escrita = 1'b0;
            mem_leitura = 1'b0;
            reg_escrita = 1'b0;
            branch = 1'b0;
            jump = 1'b0;
            sign_zero = 1'b1;
        end
        else begin
            case (opcode)
                TIPO_R: begin
                    ula_opcode = 2'b0;
                    reg_dest = 2'b0;
                    mem_to_reg = 2'b0;
                    ula_src = 1'b0;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b1;
                    branch = 1'b0;
                    jump = 1'b0;
                    sign_zero = 1'b1;
                end
                ADDI: begin
                    ula_opcode = 2'b1;
                    reg_dest = 2'b1;
                    mem_to_reg = 2'b0;
                    ula_src = 1'b1;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b1;
                    branch = 1'b0;
                    jump = 1'b0;
                    sign_zero = 1'b1;
                end
                SLTI: begin
                    ula_opcode = 2'b10;
                    reg_dest = 2'b1;
                    mem_to_reg = 2'b0;
                    ula_src = 1'b1;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b1;
                    branch = 1'b0;
                    jump = 1'b0;
                    sign_zero = 1'b0;
                end
                LW: begin
                    ula_opcode = 2'b1;
                    reg_dest = 2'b1;
                    mem_to_reg = 2'b1;
                    ula_src = 1'b1;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b1;
                    reg_escrita = 1'b1;
                    branch = 1'b0;
                    jump = 1'b0;
                    sign_zero = 1'b1;
                end
                SW: begin
                    ula_opcode = 2'b1;
                    reg_dest = 2'b1;
                    mem_to_reg = 2'b0;
                    ula_src = 1'b1;
                    mem_escrita = 1'b1;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b0;
                    branch = 1'b0;
                    jump = 1'b0;
                    sign_zero = 1'b1;
                end
                BEQ: begin
                    ula_opcode = 2'b11;
                    reg_dest = 2'b1;
                    mem_to_reg = 2'b0;
                    ula_src = 1'b0;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b0;
                    branch = 1'b1;
                    jump = 1'b0;
                    sign_zero = 1'b1;
                end
                J: begin
                    ula_opcode = 2'b0;
                    reg_dest = 2'b0;
                    mem_to_reg = 2'b0;
                    ula_src = 1'b0;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b0;
                    branch = 1'b0;
                    jump = 1'b1;
                    sign_zero = 1'b1;
                end
                JAL: begin
                    ula_opcode = 2'b0;
                    reg_dest = 2'b10;
                    mem_to_reg = 2'b10;
                    ula_src = 1'b0;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b1;
                    branch = 1'b0;
                    jump = 1'b1;
                    sign_zero = 1'b1;
                end
                default: begin
                    ula_opcode = 2'b0;
                    reg_dest = 2'b0;
                    mem_to_reg = 2'b0;
                    ula_src = 1'b0;
                    mem_escrita = 1'b0;
                    mem_leitura = 1'b0;
                    reg_escrita = 1'b1;
                    branch = 1'b0;
                    jump = 1'b0;
                    sign_zero = 1'b1;
                end
            endcase
        end
    end
    
endmodule