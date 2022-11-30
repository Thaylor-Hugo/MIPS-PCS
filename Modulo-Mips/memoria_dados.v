module memoria_dados (
    input clock, permisao_escrita, permisao_leitura,
    input [15:0] endereco, dado_escrita,
    output [15:0] dado_leitura
);  
    /* Byte aligned memory; capacidade de 128 palavras de 16 bits*/
    /* Padrao de armazenamento: little endian byte order */

    reg [7:0] ram [255:0];  
    integer i;  
    initial begin
        for(i=0;i<256;i=i+1)  
            ram[i] <= 8'd0;  
    end  
    always @(posedge clock) begin  
        if (permisao_escrita)  
            {ram[endereco+1], ram[endereco]} <= dado_escrita;
    end  
    
    assign dado_leitura = permisao_leitura? {ram[endereco+1], ram[endereco]}: 16'd0;   
endmodule