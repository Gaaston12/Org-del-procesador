;PROGRAMA: Crea una secuencia de datos consecutivos en la memoria
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
						;Por ejemplo para hacer uso de dump_regs, que lo que hace es imprimir el estado de los
						;registros por pantalla
segment .data
l1 db 0, 1, 2, 4		;Se definen 4 bytes de memoria (Secuencias de memoria)
l2 db "h", "o", "l", "a", 0		;Secuencia de memoria de 4 bytes
l3 db "hola", 0					;Lo mismo que l2
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
;
	mov eax, [l1]	;Muevo a eax lo que contiene l1, que son 4 bytes consecutivos
	mov ebx, [l2]	;Muevo en ebx lo que contiene l2. Recordar que lo que se almacenan no son caracteres, sino números
	mov ecx, [l3]	;Muevo a ecx lo mismo que l2
	dump_regs 1
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 