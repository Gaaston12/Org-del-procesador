;Pablo Etcheverry
;etcheverrypablol@gmail.com
;githug: etcheverrypablol
;21-10-16
;PROGRAMA: Retome el ejercicio Nro.6 de la práctica anterior. Utilizando la solución propuesta.
;Construya una librería (subrutina global) en assembler para calcular a nivel de bits si un número es par.
;Luego utilice esta librería desde un programa C para determinar si un número es par.

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data


segment .bss


segment .text
	global asm_main
	global es_par
asm_main:
	enter 0, 0	;rutina de 
	pusha



	popa
	mov	eax,0 	;retornar a C
	leave
	ret
es_par:
	push ebp			;Coloca en la pila la dirección vieja del EBP
	mov ebp, esp 		;Coloca el EBP donde está el ESP, para estar al lado de los parámetros
	mov eax, [ebp+8] 	;Coloco en eax el parámetro. Este parámetro se había colocado en la pila
						;en el momento en que se declara la variable en  C 

	inc eax				;Al número que está en eax le suma 1. 
	and eax, 1			;Si el número terminaba en 0, al sumarle 1, termina en 1, y con el and queda 1. 
						;Luego, si el número es par, retorna 1

	pop ebp 			;Retorna el EBP a su dirección vieja
	ret 				;Retorna a la siguiente instrucción
 
;fin del programa 