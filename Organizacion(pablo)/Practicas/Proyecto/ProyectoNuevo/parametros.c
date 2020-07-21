// Trabajo Final de la materia Organización del Procesador
// 2016
// Inegrantes: Ameri Pablo, Etcheverry Pablo, Sanchez Diego
// Tema: Aritmética Intervalar

#include <stdio.h>
#include <stdlib.h>

// Unión almacena en un arreglo los límites del número intervalar y pasa esos 
// dos límites en un mismo registro en assembler. El primer número del arreglo
// lo guarda en la parte alta de eax, y el segundo en la parte baja de eax (ax). 

typedef union intervalo{
	unsigned int i;			// Número sin signo que se usa para almancenar la dirección
							// de memoria del arreglo
	short limite[2];		// Array de dos enteros
}TIntervalo;

// Perfiles de las funciones llamadas desde assembler.
// Se declaran para que C sepa cuáles y cuántos parámetros
// recibe cada una de las funciones
TIntervalo sum_intervalo(TIntervalo int1 ,TIntervalo int2);    
TIntervalo res_intervalo(TIntervalo int1, TIntervalo int2); 
TIntervalo mul_intervalo(TIntervalo int1, TIntervalo int2); 
TIntervalo inf_intervalo(TIntervalo int1, TIntervalo int2); 
TIntervalo sup_intervalo(TIntervalo int1, TIntervalo int2); 

// Perfil de una función de C
void ImprimirResultados(char cadena[], TIntervalo int1, TIntervalo int2, TIntervalo intResul);

int main(void)
{
   char resp;
	// intervalos que se usan para las operaciones intervalares   
	union intervalo int1; 		// hace referencia al primer intervalo
	union intervalo int2 ; 		// hace referencia al segundo intervalo
	union intervalo intResul ; 	// hace referencia al resultado intervalar

	// do while que permite realizar más operaciones		
    do{
   	printf("Por favor, ingrese números que pertenezcan al intervalo [-32768,32767]\n");
    printf("lim_inf intervalo1: ");
    // se corrobora de que se ingresen sólo enteros
    while (scanf("%hd", &int1.limite[0]) != 1) {
		if (scanf("%hd", &int1.limite[0]) != 1) {
	   		printf("Error! No es un numero!\n");
	   		/* Limpia el buffer del stdin (Evita el ciclo infinito) */
	   		while (getchar() != '\n');
	  	}
	}

	printf("lim_sup intervalo1: ");
    while (scanf("%hd", &int1.limite[1]) != 1) {
		if (scanf("%hd", &int1.limite[1]) != 1) {
	   		printf("Error! No es un numero!\n");
	   		/* Limpia el buffer del stdin (Evita el ciclo infinito) */
	   		while (getchar() != '\n');
	  	}
	}	

	printf("lim_inf intervalo2: ");
    while (scanf("%hd", &int2.limite[0]) != 1) {
		if (scanf("%hd", &int2.limite[0]) != 1) {
	   		printf("Error! No es un numero!\n");
	   		/* Limpia el buffer del stdin (Evita el ciclo infinito) */
	   		while (getchar() != '\n');
	  	}
	}

	printf("lim_sup intervalo2: "); 
    while (scanf("%hd", &int2.limite[1]) != 1) {
		if (scanf("%hd", &int2.limite[1]) != 1) {
	   		printf("Error! No es un numero!\n");
	   		/* Limpia el buffer del stdin (Evita el ciclo infinito) */
	   		while (getchar() != '\n');
	  	}
	}  	

	// muestra los resultados por pantalla
  	intResul  = sum_intervalo(int1, int2); 
  	ImprimirResultados("SUMA 		",int1,int2,intResul);
	intResul  = res_intervalo(int1, int2); 
  	ImprimirResultados("RESTA 		",int1,int2,intResul);
	intResul  = mul_intervalo(int1, int2); 
  	ImprimirResultados("MULTIPLICACIÓN	",int1,int2,intResul);
	intResul  = inf_intervalo(int1, int2); 
  	ImprimirResultados("INFIMO 		",int1,int2,intResul);
	intResul  = sup_intervalo(int1, int2); 
  	ImprimirResultados("SUPREMO 	",int1,int2,intResul);

	printf("Desea realizar otra operación intervalar? s/n:");
	scanf(" %c",&resp);

	}while(resp=='s' || resp=='S' );

	return 0;
}

// Función que se usa para mostrar los resultados de las operaciones 
// Parámetros:
//		cadena[]: Para hacer referencia a la operación 
// 		int1, int2, intResul: Hace referencia a los intervalos y su resultado
void ImprimirResultados(char cadena[], TIntervalo int1, TIntervalo int2, TIntervalo intResul){
	printf("%s [%hi,%hi] [%hi,%hi] = [%hi,%hi] \n", cadena,int1.limite[0], int1.limite[1], int2.limite[0], int2.limite[1], intResul.limite[0], intResul.limite[1]);
}

