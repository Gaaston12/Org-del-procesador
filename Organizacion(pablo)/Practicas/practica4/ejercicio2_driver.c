//Pablo Etcheverry
//etcheverrypablol@gmail.com
//githug: etcheverrypablol
//21-10-16
//PROGRAMA: Hace uso de la subrutina en assembler que dice si un número es par o no
int main(){

		
	int num;	//Variable que se crea para almacenar un número desde el teclado. 
				//Es la que se guarda en la pila, para luego ser usada por la subtutina es_par y se accdede con [ebp + 8]

	int esPar;
	printf("%s\n", "Ingrese un número: " );		//Imprime por pantalla la cadena
	scanf("%i",&num);							//Lee un número desde la entrada estandar (El teclado)
	esPar=es_par(num);							//Es par retorna 1 en caso de que sea par o 0 en caso contrario			
	if (esPar)
		printf("%s\n", "El número ingresado es par." );					
	else
		printf("%s\n", "El número ingresado NO es par. " );
}