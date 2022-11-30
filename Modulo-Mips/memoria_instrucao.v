module memoria_instrucao (
    input [15:0] pc,
    output [15:0] instrucao
);
    /* Memoria de instrucao que busca testar todas as instrucoes de processador */
    /* Instrucoes criam um loop, todas as 19 instrucoes sao executadas */
    /* Nao contem instrucoes do tipo xor ($1 = $2 ^ $3), sll ($1 = $2 << $3) e srl ($1 = $2 >> $3), pois foram acrescentadas depois */

    wire [14:0] endereco = pc[15:1]; /* Por ser estilo Byte aligned ultimo byte e desconsiderado */
    reg [15:0] rom [63:0];  /* 64 espaços de memoria */
    integer i;

    initial begin  
        rom[0] = 16'b0110000010000000;  /* lw $1, 0($0)     | $1 = 0*/
        rom[1] = 16'b0110000100000000;  /* lw $2, 0($0)     | $2 = 0*/
        rom[2] = 16'b0010000010010100;  /* addi $1, $0, 20  | $1 = 20 */
        rom[3] = 16'b0010010100001111;  /* addi $2, $1, 15  | $2 = 35 */
        rom[4] = 16'b0000010100110100;  /* slt $3, $1, $2   | $3 = 1 */
        rom[5] = 16'b0100101000011110;  /* slti $4, $2, 30  | $4 = 0 */
        rom[6] = 16'b0000111001010010;  /* and $5, $3, $4   | $5 = 0 */
        rom[7] = 16'b0000111001100011;  /* or $6, $3, $4    | $6 = 1 */
        rom[8] = 16'b1010111100000100;  /* beq $3, $6, 4    | avanca 4 enderecos se $3 == $6 */
        rom[9] = 16'b0000100010110001;  /* sub $3, $2, $1   | $3 = 15 */
        rom[10] = 16'b1000000110000010; /* sw $3, 2($0)     | mem[2] = 15 */
        rom[11] = 16'b0001110000001000; /* jr $7            | goto rom[15] */
        rom[12] = 16'b0000010101000010; /* and $4, $1, $2   | $4 = 0 */
        rom[13] = 16'b0000010101010011; /* or $5, $1, $2    | $5 = 55 */
        rom[14] = 16'b1110000000001001; /* jal 9            | $7 = 15 */
        rom[15] = 16'b1000001000000100; /* sw $4, 4($0)     | mem[4] = 0 */
        rom[16] = 16'b1000001010000110; /* sw $5, 6($0)     | mem[6] = 55 */
        rom[17] = 16'b0001001011100000; /* add $6, $4, $5   | $6 = 55 */
        rom[18] = 16'b1100000000000000; /* jump 0           | goto 0 */
        for (i=19; i<64; i=i+1)
            rom[i] = 16'b0;

    end  
    
    /* So devolve uma instrucao se o endereco estiver dentro do tamanho da memoria */
    assign instrucao = (pc[15:0] < 64 )? rom[endereco]: 16'd0;

endmodule