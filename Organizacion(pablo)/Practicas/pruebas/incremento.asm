;PROGRAMA 

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
						;Por ejemplo para hacer uso de dump_regs, que lo que hace es imprimir el estado de los
						;registros por pantalla
segment .data
l1 dd 0FFFFFFFFh		;Declaro un label de un byte y le asigno 1 en decimal

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
	;mov eax, 0		;Para colocar todos ceros en eax
	;mov al, [l1]	;al=[l1]. Decido usar al, ya que l1 contiene un byte
	;inc al
	;dec al

	mov eax, [l1]
	inc eax
	dump_regs 1

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 
