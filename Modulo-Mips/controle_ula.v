module controle_ula #(
    parameter TIPO_R = 2'b00,
    parameter ADDI = 2'b01,
    parameter SLTI = 2'b10,
    parameter BEQ = 2'b11,
    parameter ADD = 4'b0000,
    parameter SUB = 4'b0001,
    parameter AND = 4'b0010,
    parameter OR = 4'b0011,
    parameter MENOR = 4'b0100,
    parameter XOR = 4'b0101,
    parameter SLL = 4'b0110, /* shift left logical */
    parameter SRL = 4'b0111 /* shift right logical */
) (
    input [1:0] ula_opcode,
    input [3:0] funcao,
    output controle_jr,
    output reg [2:0] ula_control
);

    /* Define o codigo de controle da ula baseado no opcode da ula e na funcao da instrucao */

    always @(ula_opcode or funcao) begin
        case (ula_opcode)
            TIPO_R: begin
                case (funcao)
                    ADD: ula_control = 3'b000;
                    SUB: ula_control = 3'b001;
                    AND: ula_control = 3'b010;
                    OR: ula_control = 3'b011;
                    MENOR: ula_control = 3'b100;
                    XOR: ula_control = 3'b101;
                    SLL: ula_control = 3'b110;
                    SRL: ula_control = 3'b111;
                    default: ula_control = 3'b000;
                endcase
                end
            ADDI: ula_control = 3'b000;
            SLTI: ula_control = 3'b100;
            BEQ: ula_control = 3'b001;
            default: ula_control = 3'b000;
        endcase
    end

    /* Diz se instrucao e do tipo jump register (jr) */
    assign controle_jr = ({ula_opcode, funcao} == 6'b001000)? 1'b1 : 1'b0;
    
endmodule