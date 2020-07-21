/* Biblioteca standar imput output */
#include <stdio.h>

	typedef struct intervalo{
		int lim_inf;
		int lim_sup;
	}TIntervalo;	/*Esta estructura sirve para representar un intervalo*/

int main(){

	TIntervalo intervalo1;
	TIntervalo intervalo2;

   /* printf("%s\n", "PROYECTO DE ORGANIZACION"); */
	puts("Ingrese el primer intervalo: ");
	puts("Ingrese el límite inferior: ");
	scanf("%d",&intervalo1.lim_inf);
	puts("Ingrese el límite superior: ");
	scanf("%d",&intervalo1.lim_sup);

	puts("Ingrese el segundo intervalo: ");
	puts("Ingrese el límite inferior: ");
	scanf("%d",&intervalo2.lim_inf);
	puts("Ingrese el límite superior: ");
	scanf("%d",&intervalo2.lim_sup);

	int res=suma_intervalar(intervalo1.lim_inf,intervalo1.lim_sup,intervalo2.lim_inf,intervalo2.lim_sup);

	printf("%d\n",res );
	return res;
}