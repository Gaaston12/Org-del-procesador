%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
					
segment .data
l1 dd 0000000004h  		;Se crea un label y se le asigna el valor double 4 en hexadecimal

segment .bss

segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha


	mov eax, [l1]	;Muevo en eax 0000000004h

	dump_regs 0
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 