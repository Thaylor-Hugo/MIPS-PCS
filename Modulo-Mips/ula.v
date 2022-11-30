module ula #(
    parameter ADD = 3'b000,
    parameter SUB = 3'b001,
    parameter AND = 3'b010,
    parameter OR = 3'b011,
    parameter MENOR = 3'b100,
    parameter XOR = 3'b101,
    parameter SLL = 3'b110, /* shift left logical */
    parameter SRL = 3'b111  /* shift right logical */
) (
    input [15:0] a, b,
    input [2:0] ula_control,
    output reg [15:0] resultado, 
    output zero 
);
    /* Ula com 5 operacoes e alerta de zero */
    always @(*) begin
        case (ula_control)
            ADD: resultado = a + b;
            SUB: resultado = a - b; 
            AND: resultado = a & b; 
            OR: resultado = a | b;
            MENOR: begin
                    if (a < b) resultado = 16'd1;
                    else resultado = 16'd0;    
                end 
            XOR: resultado = a ^ b;
            SLL: resultado = a << b;
            SRL: resultado = a >> b;
            default: resultado = a + b;
        endcase
    end

    /* Diz se o resultado e zero */
    assign zero = (resultado==16'd0) ? 1'b1: 1'b0;
endmodule
