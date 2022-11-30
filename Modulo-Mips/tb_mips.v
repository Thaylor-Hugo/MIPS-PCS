`timescale 1ns/1ps

module tb_mips;

    reg reset;
    reg clock = 0;
    wire [15:0] pc;

    initial begin
        $dumpfile("tb_mips.vcd");
        $dumpvars(0,tb_mips);
    end

    always #1 clock = !clock;

    mips mips (clock, reset, pc);
    initial begin
        /* Varia o reset para testar o processador. Com a waveform e possivel verificar se as instrucoes foram realizadas corretamente */
        /* A memoria de instrucoes pode ser alterada para testar diferentes intrucoes */
        /* Por padrao a memoria de instrucoes segue um loop que realiza ao menos uma vez a maior parte das instrucoes possiveis */

        reset = 1;
        #99;
        reset = 0;
        #100;
        reset = 1;
        #100;
        reset = 0;
        #100;
        reset = 1;
        #100; 
        $finish;
    end 

    initial begin
        $monitor("reset=%d | pc=%d", reset, pc);
    end
    
endmodule