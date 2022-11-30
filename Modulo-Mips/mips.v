module mips (
    input clock, reset,
    output [15:0] pc
);
    /* Processador MIPS 16-bits de ciclo unico */

    /* Entradas e saidas dos modulos que compoem o processador */
    wire [15:0] pc_atual, instrucao;
    wire [1:0] ula_opcode, reg_dest, mem_to_reg;
    wire ula_src, mem_escrita, mem_leitura, reg_escrita, branch, jump, sign_zero;
    wire [2:0] endereco_regd, endereco_reg1, endereco_reg2;
    wire [15:0] dado_escrita, dado_leitura_memoria, valor_reg1, valor_reg2;
    wire jr, alerta_zero;
    wire [2:0] ula_control;
    wire [15:0] resultado_ula, immediato_extended, dado_leitura;

    contador_programa contador_programa (clock, reset, (branch & alerta_zero), jump, jr, 
                                        valor_reg1, instrucao[12:0], immediato_extended, pc_atual);

    memoria_instrucao memoria_instrucao ((pc_atual), (instrucao));

    controle controle(instrucao[15:13], reset, ula_opcode, reg_dest, mem_to_reg, ula_src, 
                        mem_escrita, mem_leitura, reg_escrita, branch, jump, sign_zero);

    /* Multiplexador: determina se o endereço do registrador de destino sera o rd ou rt da instrucao 
                      ou $7 para instrucao jal */
    assign endereco_regd = (reg_dest==2'b10)? 3'b111: ((reg_dest==2'b01)? instrucao[9:7] : instrucao[6:4]);
    
    /* captura o endereco dos registradores na instrucao */
    assign endereco_reg1 = instrucao[12:10];    /* rs */
    assign endereco_reg2 = instrucao[9:7];      /* rt */

    banco_registradores banco_registradores (reset, clock, reg_escrita, endereco_regd, endereco_reg1, 
                                                endereco_reg2, dado_escrita, valor_reg1, valor_reg2);

    /* extende a constante imediato da instrucao com o seu sinal ou zero (caso seja instrucao slti) */
    assign immediato_extended = (sign_zero==1'b1)? {{9{instrucao[6]}}, instrucao[6:0]} : {9'b0, instrucao[6:0]};

    controle_ula controle_ula(ula_opcode, instrucao[3:0], jr, ula_control);

    /* determina se sera utilizado immediato extendido ou valor do registrador na ula, 
        depende da instrucao */
    assign dado_leitura = (ula_src==1'b1)? immediato_extended : valor_reg2;

    ula ula (valor_reg1, dado_leitura, ula_control, resultado_ula, alerta_zero);

    memoria_dados memoria_dados(clock, mem_escrita, mem_leitura, resultado_ula, valor_reg2, 
                                dado_leitura_memoria);

    /* Multiplexador: determia os dado da escrita no registrador, se e o proxixmo endereco (jal) ou se vem da memoria ou da ula */
    assign dado_escrita = (mem_to_reg == 2'b10)? (pc_atual+16'b10) : 
    ((mem_to_reg == 2'b01)? dado_leitura_memoria : resultado_ula);
    
    /* manda pra saida o endereco da instrucao realizada */
    assign pc = pc_atual;

endmodule