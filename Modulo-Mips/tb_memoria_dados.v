`timescale 1ns/1ps

module tb_memoria_dados;

    reg permisao_escrita, permisao_leitura;
    reg [15:0] endereco, dado_escrita;
    wire [15:0] dado_leitura;
    integer i;

    reg clock = 0;
    always #1 clock = !clock;

    initial begin
        $dumpfile("tb_memoria_dados.vcd");
        $dumpvars(0,tb_memoria_dados);
    end

    memoria_dados memoria_dados (clock, permisao_escrita, permisao_leitura, endereco, dado_escrita, dado_leitura);
    initial begin
        /* Checa os valores de toda a memoria */
        permisao_leitura = 1;
        permisao_escrita = 0;
        endereco = 16'b0;
        #2;
        for (i=0; i<127; i=i+1) begin
            endereco = endereco + 2;
            #2;
        end

        /* Armazena na memoria o seu endereco */
        permisao_leitura = 0;
        permisao_escrita = 1;
        endereco = 16'b0;
        dado_escrita = 16'b0;
        #2;
        for (i=0; i<127; i=i+1) begin
            endereco = endereco + 2;
            dado_escrita = dado_escrita + 2;
            #2;
        end

        /* Checa novamente os valores armazenados na memoria */
        permisao_escrita = 0;
        permisao_leitura = 1;
        endereco = 16'b0;
        #2;
        for (i=0; i<127; i=i+1) begin
            endereco = endereco + 2;
            #2;
        end

        #10 $finish;
    end 

    initial begin
        $monitor("permisao_escrita=%d | permisao_leitura=%d | endereco=%d | dado_escrita=%d | dado+leitura=%d", 
                    permisao_escrita, permisao_leitura, endereco, dado_escrita, dado_leitura);
    end
    
endmodule