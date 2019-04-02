#include <stdio.h>
int main (void) {

	char i;
	int V;
	int E;
	int D;
	int P; 	
	int Mai = 0;
	int Men = 100000;
	char Tmai;
	char Tmen;
	
	for (i=1;i<=6;i++){
		printf("Insira, respectivamente a qtd de vitorias, empates e derrotas do time %d\n", i);	
		scanf("%d", &V);
		scanf("%d", &E);
		scanf("%d", &D);
		P = 3*V + E;
		if (P > Mai){
			Tmai = i;
			Mai = P;				
		}else{

			if (P < Men){
				Tmen = i;
				Men	= P;
			}					
		}		
	}
	printf("O time com a maior qtd de pontos foi o time %hhd\n ",Tmai);
	printf("O time com a menor qtd de pontos foi o time %hhd\n ",Tmen);
	return 0;
}

