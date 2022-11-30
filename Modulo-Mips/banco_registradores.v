module banco_registradores (
    input reset, clock, permisao_escrita,
    input [2:0] endereco_regd, endereco_reg1, endereco_reg2,
    input [15:0] dado_escrita,
    output [15:0] valor_reg1, valor_reg2
);
    /* Banco composto por 8 registradores de 16 bits */

    integer i;
    reg [15:0] registradores [7:0]; 

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            for (i=0; i<8; i=i+1) begin
                registradores[i] <= 16'b0;
            end
        end 
        else if (permisao_escrita)
            registradores[endereco_regd] = dado_escrita;
    end
    
    /* registradores[0] reservado -> sempre retorna 0 */
    /* registradores[7] padrao para armazenar pc na instrucao jal */

    assign valor_reg1 = (endereco_reg1 == 0)? 16'b0 : registradores[endereco_reg1];
    assign valor_reg2 = (endereco_reg2 == 0)? 16'b0 : registradores[endereco_reg2];
    
endmodule
