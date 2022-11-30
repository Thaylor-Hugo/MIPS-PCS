`timescale 1ns/1ps

module tb_controle;

    reg [2:0] opcode;
    reg reset;
    wire [1:0] ula_opcode, reg_dest, mem_to_reg;
    wire ula_src, mem_escrita, mem_leitura, reg_escrita, branch, jump, sign_zero;
    integer i;

    initial begin
        $dumpfile("tb_controle.vcd");
        $dumpvars(0,tb_controle);
    end

    controle controle (opcode, reset, ula_opcode, reg_dest, mem_to_reg, ula_src, mem_escrita, 
                        mem_leitura, reg_escrita, branch, jump, sign_zero);
    initial begin
        reset = 1;
        #10;
        reset = 0;

        /* Teste todas as possibilidades de opcode e reseta ao fim */
        opcode = 3'b0;
        #2;
        for (i=0; i<7; i=i+1) begin
            opcode = opcode + 1;
            #2;
        end

        reset = 1;
        #10;
        reset = 0;
        #10 $finish;
    end 

    initial begin
        $monitor("reset = %b | opcode = %b | ula_opcode = %b | reg_dest = %b | mem_to_reg = %b | ula_src = %b | mem_escrita = %b | mem_leitura = %b | reg_escrita = %b | branch = %b | jump = %b | sign_zero = %b", 
                    reset, opcode, ula_opcode, reg_dest, mem_to_reg, ula_src, mem_escrita, mem_leitura, reg_escrita, branch, jump, sign_zero);
    end
    
endmodule