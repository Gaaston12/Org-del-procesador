/*Pablo Etcheverry
etcheverrypablol@gmail.com
githug: etcheverrypablol
24-10-16
PROGRAMA: Programa en C que lo que hace es llamar a una subrutina de assmebler (asm_main),
que está declarada de manera global
*/
int asm_main(); 	//Se coloca para que el compilador no lanze un warning
					//Con esto el compilador sabe lo que la función retorna
					//y los parámetros que recibe
int main(){

		
	int num=asm_main();		//Crea una variable entera y le asigna lo que retorna
							//la subrutina assembler
	return num;
}