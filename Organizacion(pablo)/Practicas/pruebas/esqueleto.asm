%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data


segment .bss


segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha



	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 