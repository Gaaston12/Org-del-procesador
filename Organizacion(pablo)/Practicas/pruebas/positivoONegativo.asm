;PROGRAMA: DETECTA SI ÉL NÚMERO ENTERO INGRESADO ES POSITIVO O NEGATIVO
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
out_msg1	db	"PROGRAMA QUE DETECTA SI UN NÚMERO ES POSITIVO O NEGATIVO", 0
out_msg2	db	"Ingrese un número entero: ", 0
pos_msg		db	"El número ingresado es POSITIVO", 0
neg_msg		db  "Eĺ número ingresado es NEGATIVO ", 0
segment .bss
imput resd	1

segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, out_msg1		;Muevo en eax la cadena de texto que explica que hace el programa
	call print_string		;Imprime la cadena que está en eax
	call print_nl
	mov eax, out_msg2		;Muevo en eax el mensaje que pide que ingrese un número entero
	call print_string		;Imprime la cadena que está en eax

	call read_int
	mov [imput], eax 		;Muevo en imput el entero que se ha ingresado
		
	cmp eax, 0				;Compara el entero ingresado con el cero
	
	jge 	thenBlock		;Si [imput]>=0, entonces llama al bloque then (jge salta si vleft>=vrirth)
	mov eax, neg_msg		;Mueve en eax el mensaje que dice que es negativo
	call print_string		;
	jmp next				;Salto a next en caso de que sea distinto de cero

thenBlock:
	mov eax, pos_msg		;Coloco en eax el mensaje que dice que es positivo
	call print_string
next:

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 