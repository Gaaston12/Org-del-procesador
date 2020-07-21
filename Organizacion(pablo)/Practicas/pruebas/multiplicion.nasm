;PROGRMAA: Se hace uso de la función mul para números sin signos y de imul para números con signo
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
l1 db 10
l2 db 2
segment .bss


segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, 0			;Para colocar todos ceros en eax
	mov al, [l1] 		;Coloco en al el 10
	mul byte [l2]		;Multiplico 2 por lo que tenía al, y lo coloca en ax

	imul ax, [l2]		;Multiplico lo que tiene ax por lo que hay en l2 (20*2)

	dump_regs 0			;Imprime por pantalla lo que contiene los registros
	
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 