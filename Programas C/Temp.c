#include <stdio.h>
int main (void) {
    char temps[10];
    char i = 0;    
    int Total = 0;    
    float med = 0;
    char sum = 0;   
    while (i < 10){
        printf("Insira a temperatura (Entre -100 e 100): ");       
        scanf("%hhd",&temps[i]);
        Total = Total + temps[i];
        i= i + 1;        
    }    
    i = 0;    
    med = Total/10;   
    printf("A média foi %.2f. Total = %d", med, Total );    
    while (i < 10){
        if (temps[i] > med){
            sum = sum +1; 
        }
        i=i+1;    
    }
    printf("A quantidade de leituras, acima da média foi %hhd.", sum);
    

}
