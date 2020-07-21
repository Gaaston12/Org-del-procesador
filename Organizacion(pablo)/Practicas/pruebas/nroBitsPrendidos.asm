%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
num 	db 		50h		;1010000

segment .bss


segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, [num]
	mov ecx, 32				;Es el registro que va a ir decreciedo hasta que llegue a cero
	mov bl, 0				;Es donde se va a ir guardando la cantidad de bit prendidos que hay en el número
loop_prendidos:
	shl eax, 1				;Shiftea hacia la izquierda el número 
	jnc siguiente			;Si FC == 0, entonces salta hacia siguiente
	add bl, 1
siguiente:
	loop loop_prendidos 	;Va a ir decreciendo el registro ecx de uno en uno

	mov eax, 0
	mov al, bl
	call print_int

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 