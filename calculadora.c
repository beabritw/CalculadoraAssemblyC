#include <stdio.h>

void calcular(float num1, float num2, char operador) {
    float resultado;
    
    switch (operador) {
        case '+':
            resultado = num1 + num2;
            printf("\n----------------------------\n");
            printf("  Resultado: %.2f\n", resultado);
            printf("-------------------------------\n\n");
            break;

        case '-':
            resultado = num1 - num2;
            printf("\n---------------------------\n");
            printf("  Resultado: %.2f\n", resultado);
            printf("-----------------------------\n\n");
            break;

        case '*':
            resultado = num1 * num2;
            printf("-----------------------------\n\n");
            printf("  Resultado: %.2f\n", resultado);
            printf("-----------------------------\n\n");
            break;

        case '/':
            if (num2 != 0) {
                resultado = num1 / num2;
                printf("-----------------------------\n\n");
                printf("  Resultado: %.2f\n", resultado);
                printf("-----------------------------\n\n");
            } else {
                printf("-----------------------------\n\n");
                printf("  Erro: Divisão por zero!\n");
                printf("-----------------------------\n\n");
            }

            break;

        default:
            printf("  Operador inválido!\n");
    }
}

int main() {
    float num1, num2;
    char operador;
    
    printf("---------------------------\n"
    printf("  C A L C U L A D O R A  \n");
    printf("---------------------------\n\n");
    
    printf("Digite o primeiro número: ");
    scanf("%f", &num1);
    
    printf("Digite o operador: (+, -, *, /): ");
    scanf(" %c", &operador);
    
    printf("Digite o segundo número: ");
    scanf("%f", &num2);
    
    calcular(num1, num2, operador);

    return 0;
}