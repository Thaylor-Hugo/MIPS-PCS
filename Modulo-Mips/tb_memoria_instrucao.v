`timescale 1ns/1ps

module tb_memoria_instrucao;

    reg [15:0] pc;
    wire [15:0] instrucao;
    integer i;

    initial begin
        $dumpfile("tb_memoria_instrucao.vcd");
        $dumpvars(0,tb_memoria_instrucao);
    end

    memoria_instrucao memoria_instrucao (pc, instrucao);
    initial begin

        /* Testa todos os enderecos para pc ate 140 (max(rom) = 64) */

        pc = 16'b0;
        for (i=0; i<70; i=i+1)
            #2 pc=pc+2;
    end 

    initial begin
        $monitor("pc=%d | insttrucao = %b", pc, instrucao);
    end
    
endmodule