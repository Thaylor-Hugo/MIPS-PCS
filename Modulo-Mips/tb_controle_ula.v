`timescale 1ns/1ps

module tb_controle_ula;

    reg [1:0] ula_opcode;
    reg [3:0] funcao;
    wire [2:0] ula_control;
    wire controle_jr;

    integer i, j;

    initial begin
        $dumpfile("tb_controle_ula.vcd");
        $dumpvars(0,tb_controle_ula);
    end

    controle_ula controle_ula (ula_opcode, funcao, controle_jr, ula_control);
    
    initial begin
        /* Testa todas as combinacoes de opcode e funcao */
        
        ula_opcode = 2'b11;
        funcao = 4'b0;
        for (j=0; j<4; j=j+1) begin
            ula_opcode = ula_opcode + 1;
            for (i=0; i<16; i=i+1) begin
                #2;
                funcao = funcao + 1;
            end
            #2;
            funcao = 0;

        end
    end 

    initial begin
        $monitor("ula_opcode = %b | funcao = %b | ula_control = %b | controle_jr = %b", 
                    ula_opcode, funcao, ula_control, controle_jr);
    end
    
endmodule