# CalculadoraAssemblyC

Este projeto é uma calculadora simples feita com a combinação de Assembly e C para a matéria de Paradigmas de Linguagens para Programação. O objetivo é comparar as diferenças entre as duas como o desempenho, a flexibilade e legibilidade das linguagens num exemplo simples que é uma calculadora.

## Arquivos

*calculadora.asm:* Contém o código Assembly que realiza as operações aritméticas.

*calculadora.c:* O código em C que interage com as funções em Assembly e gerencia as entradas e saídas do usuário.

*calculadora.o:* O arquivo objeto gerado ao compilar o código Assembly.

## Como Compilar?

nasm -f elf64 calculadora.asm
gcc calculadora.c calculadora.o -o calculadora
./calculadora

