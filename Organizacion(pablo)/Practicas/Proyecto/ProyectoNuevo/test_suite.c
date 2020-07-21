// Trabajo Final de la materia Organización del Procesador
// 2016
// Inegrantes: Ameri Pablo, Etcheverry Pablo, Sanchez Diego
// PROGRAMA: Test Suit para ejercitar los distintos casos en las operaciones intervalares
// El programa puede retornar con un OK en caso de que todo esté bien, o con un error

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

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

void test_op_intervalares(void);
void gotoxy(int x, int y);
void test_operacion(int *i, int j, int op, TIntervalo int1, TIntervalo int2, TIntervalo intResul, TIntervalo intResulAux);

// intervalos que se usan para las operaciones intervalares   
TIntervalo int1; 			// hace referencia al primer intervalo
TIntervalo int2 ; 			// hace referencia al segundo intervalo
TIntervalo intResul ; 		// hace referencia al resultado intervalar
TIntervalo intResulAux ; 	// para hacer uso del assert()

// Arreglo de enteros usado para almacenar casos de pruebas para el Test Suit
int test[500]=	{	
// Casos de prueba para las suma	 
/* Lín0  */			 1,		2,		3,		4,		4,		6,	//		[1,2]  +  [3,4] = [4,6]
/* Lín1  */		-32768,		0,		0,		0, -32768,		0,	//	[-32000,0] + [0, 0] = [-32768,0]
/* Lín2  */			 0,	32767,		0,		0,		0,	32767, 	//	 [0,32767] +  [0,0] = [0,32767]
/* Lín3  */		-32768,		0,	   -1,		0,		1,		0,	// 	[-32768,0] + [-1,0] = [1,0]
/* Lín4  */			 0,	32767,		0,		1,		1,		0,	// 	 [0,32767] +  [0,1] = [1,0]
/* Lín5  */			 2, 	1,     	4,		3,		4,		6,  // 		 [2,1] +  [4,3] = [4,6]
// OBSERVACIÓN: Cuando se pasa de representación assembler retorna el intervalo [1,0], forma
// que usamos para representar un intervalo inválido.

//	Casos de prueba para la resta			

/* Lín6  */			1,		2,		3,		5,	   -3,	   -2,	//		[1,2]  -  [3,4] = [-2,-2]
/* Lín7  */		-32768,		0,		0,		0, -32768,		0,	//	[-32000,0] - [0, 0] = [-32768,0]
/* Lín8  */			 0,	32767,		0,		0,		0,	32767, 	//	 [0,32767] -  [0,0] = [0,32767]
/* Lín9  */		-32768,		0,	   	1,		2,		1,		0,	// 	[-32768,0] - [1,2]  = [1,0]
/* Lín10 */			 0,	32767,		-2,	   -1,		1,		0,	// 	 [0,32767] -[-2,-1] = [1,0]
/* Lín11 */			 1, 	3,     	4,		5,	   -3,	   -2,  // 		 [2,1] -  [4,3] = [4,6]
// Casos de prueba para la multiplicación
				
/* Lín12 */			 1, 	2, 		3,		4, 		3,		8, 	// 		[1,2] * [3,4] = [3,8]
/* Lín13 */			 2, 	1, 		3,		4, 		3,		8,	// 		[2,1] * [3,4] = [3,8]
/* Lín14 */			 1, 	2, 		4,		3, 		3,		8,	// 		[1,2] * [4,3] = [3,8]
/* Lín15 */			 2, 	1, 		4,		3, 		3,		8,	//		[2,1] * [4,3] = [3,8]
/* Lín16 */			 0, 	0, 		0,		0, 		0,		0,	// 	   	[0,0] * [0,0] = [0,0]
/* Lín17 */			-1,    -1, 	   -1,	   -1, 		1,		1,	//  [-1,-1] * [-1,-1] = [1,1]
/* Lín18 */			-1,    -2, 	    3,	    4, 	   -8,	   -3,	//	  [-1,-2] * [3,4] = [-8,-3]
/* Lín19 */			-1,    -2, 	   -3,	   -4, 	    3,	    8,	//  [-1,-2] * [-3,-4] = [3,8]
/* Lín20 */		 16384, 	1,	   -2,		1, -32768, 	16384, 	//	[16384,1] * [-2,1]= [-32768,1] 
/* Lín21 */		 16384, 	1,	    2,		1,      1, 	    0, 	//  [16384,1] * [2,1] = [1,0] 
/* Lín22 */		  4681,		1,		1,		7,		1, 	32767, 	//	 [4681,1] * [1,7] = [1,32767]				
/* Lín23 */		  3641,		1,		1,	   -9,		1, 	    0, 	//	 [3641,1] * [1,-9]= [1,0]				

// Casos de pruebas para el ínfimo (Intersección)				  				

/* Lín24 */			0,		0,		0,		0,		0,		0, 	// 		[0,0] inf [0,0] = [0,0]
/* Lín25 */			1, 		2,		3,		4,		1,		0, 	// 		[1,2] inf [3,4] = [1,0]
/* Lín26 */			1,		3, 		2,		4,		2,		3,	// 		[1,3] inf [2,4] = [2,3]
/* Lín27 */			2, 		3,		1,		4,		2,		3,  // 		[2,3] inf [1,4] = [2,3]
/* Lín28 */			1, 		4,		2,		3,		2,		3,	// 	    [1,4] inf [2,3] = [2,3]
/* Lín29 */			2,		4,		1,		3,		2,		3,	// 	    [2,4] inf [1,3] = [2,3]
/* Lín30 */			1,		2,		2,		3,		2,		2,  // 		[1,2] inf [2,3] = [2,2]
// Casos de prueba para el supremo (Unión)

/* Lín31 */			0,		0,		0,		0,		0,		0, 	// 		[0,0] U [0,0] = [0,0]
/* Lín32 */			1,		2,		3,		4,		1,		4, 	// 		[1,2] U [3,4] = [1,4]
/* Lín33 */			1,		2,		4,		5,		1,		0, 	// 		[1,2] U [4,5] = [1,0]
/* Lín34 */			1,		2,		2,		3,		1,		3, 	// 		[1,2] U [2,3] = [1,3]
/* Lín35 */			1,		4,		2,		3,		1,		4, 	// 		[1,4] U [2,3] = [1,4]
/* Lín36 */		   -3,	   -2,	   -4,	   -1,	   -4,	   -1, 	// 		[0,0] U [0,0] = [0,0]
/* Lín37 */		   -2,	   -3,	   -4,	   -1,	   -4,	   -1, 	// 		[0,0] U [0,0] = [0,0]
				'\0'};	// Caracter de fin de arreglo


int main(int argc, char const *argv[])
{

	test_op_intervalares();	
	return 0;
}

// Testeo de las diferentes operaciones haciendo uso de los casos que 
// se encuentran cargados en el arreglo test
void test_op_intervalares(void){
	int i = 0;
	test_operacion(&i,6,1,int1,int2,intResul,intResulAux);
	test_operacion(&i,6,2,int1,int2,intResul,intResulAux);
	test_operacion(&i,12,3,int1,int2,intResul,intResulAux);
	test_operacion(&i,7,4,int1,int2,intResul,intResulAux);
	test_operacion(&i,7,5,int1,int2,intResul,intResulAux);


	gotoxy(0,0);
	printf("El Test Suit ah finalizado correctamente..\n");
}

// Se testea una operacióń haciendo uso de un arreglo que con tiene casos 
// Parámetros:
//	i: Se usa para ir recorriendo los distintos casos 
//	j: Define la candida de casos que se prueban en la operación 
// 	int1,int2,intResul: Hacen referencia a los intervalos
//  intResulAux: Para comparar el resultado con lo esperado  
void test_operacion(int *i, int j, int op, TIntervalo int1, TIntervalo int2, TIntervalo intResul, TIntervalo intResulAux){
int k=0;
	while(k<j){
		system("clear");
		gotoxy(1,1);
		printf("Error en el caso %i del test..\n",*i/6 );
		int1.limite[0]=test[*i];
		int1.limite[1]=test[*i+1];
		int2.limite[0]=test[*i+2];
		int2.limite[1]=test[*i+3];
		intResul.limite[0]=test[*i+4];
		intResul.limite[1]=test[*i+5];
		switch(op){
			case 1:
				intResulAux = sum_intervalo(int1,int2);
				printf("SUMA..\n");
				break;
			case 2: 
				intResulAux = res_intervalo(int1,int2);
				printf("RESTA..\n");
				break;
			case 3: 
				intResulAux = mul_intervalo(int1,int2);	
				break;
			case 4: 
				intResulAux = inf_intervalo(int1,int2);	
				break;
			case 5: 
				intResulAux = sup_intervalo(int1,int2);	
				break;		
			default:
				break;
		}
		assert(intResulAux.limite[0] == intResul.limite[0] && intResulAux.limite[1] == intResul.limite[1]);
		*i=*i+6;
		k++;
	}
}

// Funcion que se usa para posicionarse en un lugar determinado en el terminal
// Parámetros:
// 		x: desplazamineto horizontal
// 		y: desplazamineto vertical
void gotoxy(int x, int y) {
    printf("%c[%d;%df", 0x1B, y, x);
}