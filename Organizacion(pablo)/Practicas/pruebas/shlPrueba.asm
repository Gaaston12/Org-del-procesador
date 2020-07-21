%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
num1 	db 	0C2h 	;/194

segment .bss


segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha
	mov eax, 0
	mov ax, [num1]
	call print_int
	dump_regs 0

	shl eax, 1

	call print_int
	dump_regs 1
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 