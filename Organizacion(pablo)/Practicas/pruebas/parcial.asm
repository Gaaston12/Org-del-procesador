%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
						;Por ejemplo para hacer uso de dump_regs, que lo que hace es imprimir el estado de los
						;registros por pantalla
segment .data
A dW 01h, 10h, 01h;
;Los datos iniciados se colocan en el segmentos de datos 
;acá
;
segment .bss
;Datos no iniciados se colocan en el segmento bss
;
segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

;
;El código será colocado en el segmento de texto. 
;Parte a
;--------------------------------------------------
	;mov eax, 0FFFFFFFFh	;Se tiene que colocar el cero, porque assembler no permite números que empiecen con F
	;mov ebx, A 			;Se mueve a ebx la dirección de memoria de A
	;mov ax, [ebx]			;Se mueve en ax el contenido de ebx. En este caso sólo se va a colocar el 0001.
;--------------------------------------------------
;Parte b

	mov eax, 0
	mov ax, [A+2]
	add ax, [A+4]

	dump_regs 1	
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 