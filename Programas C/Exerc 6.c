#include <stdio.h>
int main (void) {
 
	int N = 0;
	int i;
	int soma = 0;
	int exp;
	printf("Digite o teto (N) do somat�rio: ");
	scanf("%d", &N);
	for (i=1; i<=N; i++){
		exp = i*i;	
		soma = soma + exp ;
	}
	printf("O valor do somat�rio �: %d\n", soma);
	
	return 0;
}
