`timescale 1ns/1ps

module tb_banco_registradores;

    reg reset, permisao_escrita;
    reg [2:0] endereco_reg1, endereco_reg2, endereco_regd;
    reg [15:0] dado_escrita;
    wire [15:0] valor_reg1, valor_reg2;
    
    reg clock = 0;
    always #1 clock = !clock;

    initial begin
        $dumpfile("tb_banco_registradores.vcd");
        $dumpvars(0,tb_banco_registradores);
    end

    banco_registradores banco_registradores (reset, clock, permisao_escrita, endereco_regd, endereco_reg1, 
                                                endereco_reg2, dado_escrita, valor_reg1, valor_reg2);
    initial begin
        /* Reset para iniciar o banco */
        reset = 1;
        #10;
        reset = 0;
        /* armazena em cada registrador o valor do seu endereco */
        permisao_escrita = 1;
        endereco_regd = 3'd0;
        dado_escrita = 16'd15;  /* reg0 e reservado, testa se seu valor ira alterar */
        #2;
        endereco_regd = 3'd1;
        dado_escrita = 16'd1;
        #2;
        endereco_regd = 3'd2;
        dado_escrita = 16'd2;
        #2;
        endereco_regd = 3'd3;
        dado_escrita = 16'd3;
        #2;
        endereco_regd = 3'd4;
        dado_escrita = 16'd4;
        #2;
        endereco_regd = 3'd5;
        dado_escrita = 16'd5;
        #2;
        endereco_regd = 3'd6;
        dado_escrita = 16'd6;
        #2;
        endereco_regd = 3'd7;
        dado_escrita = 16'd7;
        #2;
        permisao_escrita = 0;
        /* checa o valor de cada registrador */
        endereco_reg1 = 3'd0;
        endereco_reg2 = 3'd1;
        #2;
        endereco_reg1 = 3'd2;
        endereco_reg2 = 3'd3;
        #2;
        endereco_reg1 = 3'd4;
        endereco_reg2 = 3'd5;
        #2;
        endereco_reg1 = 3'd6;
        endereco_reg2 = 3'd7;
        #2;
        reset = 1;
        /* Checa se o reset esta funcionando */
        #10;
        endereco_reg1 = 3'd0;
        endereco_reg2 = 3'd1;
        #2;
        endereco_reg1 = 3'd2;
        endereco_reg2 = 3'd3;
        #2;
        endereco_reg1 = 3'd4;
        endereco_reg2 = 3'd5;
        #2;
        endereco_reg1 = 3'd6;
        endereco_reg2 = 3'd7;
        #2 $finish;
    end 

    initial begin
        $monitor("reset=%d | permisao=%d | end_regd=%d | end_reg1=%d | end_reg2=%d | dado=%d | valor1=%d | valor2=%d", 
                    reset, permisao_escrita, endereco_regd, endereco_reg1, endereco_reg2, dado_escrita, valor_reg1, valor_reg2);
    end
    
endmodule