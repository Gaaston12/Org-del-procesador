%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
						;Por ejemplo para hacer uso de dump_regs, que lo que hace es imprimir el estado de los
						;registros por pantalla
veinte equ 20			;Directiva que se usa para definir un símbolo, que son constantes con números
;%define size 10		;Hasta el momento no pude hacer uso del define 
segment .data
;
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

	mov eax, 0			;Muevo a eax cero
	mov al, veinte		;Muevo a al la constante 20 definida al principio de este documento
	
	;mov ebx, 0
	;mox bl, size
	
	dump_regs 0
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 