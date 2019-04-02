#include <stdio.h>
int main (void) {
	
	int i = 0;
	int soma = 0;
	printf("Digite um valor: ");
	scanf("%d", &i);
	while (i!=0) {
		soma = soma + i;
		printf("Digite um valor: ");
		scanf ("%d", &i);	
	}
	printf("A soma dos valores digitados é: %d\n", soma);
	return 0;
}

