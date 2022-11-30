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