# MIPS-PCS
Projeto de um processador MIPS 16 bits em verilog

Projeto realizado para a disciplina PCS-3115 - Sistemas Digitais I

Processador composto pelos modulos:
  1) banco_registradores.v
  2) contador_programa.v
  3) controle_ula.v
  4) controle.v
  5) memoria_dados.v
  6) ula.v
  7) mips.v (Principal que reune os demais modulos)
  
Cada modulo se mantem em um par com seus respectivos testbenchs nomeados da forma tb_{nome-do-modulo}.v

As simulacoes foram feitas utilizando o programa Icarus Verilog

Os arquivos foram compilados com o comando:
    iverilog -o {customFilename} {nome do modulo}.v
Para a compilacao e necessario acrescentar todos os modulos utilizados, um par testbench + modulo. No caso do modulo mips, e necessario incluir alem do mips.v e do tb_mips.v todos os demais modulos, com excessao dos testbenchs.

Para a execucao da simulacao foi utilizado o comando:
    vvp {customFilename}

A analize da wave form da simulacao pode ser vista com o comando:
    gtkwave {nome do dumpfile}
Todos os dumpfile seguem a seguinte forma de nomeacao: {testbenchName}.vcd

A memoria de instrucoes padrao segue um loop de 18 instrucoes, realizando diferentes intrucoes disponiveis. Esta deve ser alterada para testar\realizar outras tarefas. O padrao das instrucoes esta disponivel no relatorio.
