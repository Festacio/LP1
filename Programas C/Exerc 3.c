# include <stdio.h>
int main (void){
	
	int vel = 0;
	scanf ("%d", &vel);
	vel = vel*1.6;
	printf("A velocidade em KM/H é %d\n ", vel);
	
	if (vel>=80 && vel<=100) {
		printf("Mantenha.");
    }else{ 
		if(vel>100) {
			printf("Reduza.");			
		}else{
			printf("Acelere.");
		}
	}
	return 0;
	}
