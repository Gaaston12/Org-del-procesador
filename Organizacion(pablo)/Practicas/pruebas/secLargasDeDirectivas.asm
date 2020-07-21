%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
						;Por ejemplo para hacer uso de dump_regs, que lo que hace es imprimir el estado de los
						;registros por pantalla
segment .data
l1 times 20 db 0 			;Equivalente a 20 veces db 0

;Los datos iniciados se colocan en el segmentos de datos 
;acá
segment .bss
l2 resb 1;
;Datos no iniciados se colocan en el segmento bss
;
segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

;
;El código será colocado en el segmento de texto. 
;
	mov eax, [l1]			;Muevo en eax lo que contiene l1, que son todos ceros consecutivos
	mov byte [l2], 1		;Muevo 1 en el byte que se encuentra en l2
	mov al, [l2]			;Muevo en al lo que contiene l2, que es un 1

	dump_regs 1	 
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 