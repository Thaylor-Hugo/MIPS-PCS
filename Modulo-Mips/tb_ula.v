`timescale 1ns/1ps
module tb_ula;

    reg [15:0] a, b; 
    reg [2:0] ula_control;
    wire [15:0] result; 
    wire zero;
    integer i;

    initial begin
        $dumpfile("tb_ula.vcd");
        $dumpvars(0,tb_ula);
    end

    ula ula (a, b, ula_control, result, zero);
    initial begin
        
        a = 16'b1000;   /* a = 8 */
        b = 16'b11;     /* b = 3 */

        /* testa cada operacao da ula para os valores de a e b */
        ula_control = 3'b0;
        for (i=0; i<7; i=i+1)
            #2 ula_control = ula_control + 1;
        
        #2 $finish;

    end 

    initial begin
        $monitor("a = %d | b = %d | ula_control = %b | resultado = %d | zero = %d", a, b, ula_control, result, zero);
    end
    
endmodule