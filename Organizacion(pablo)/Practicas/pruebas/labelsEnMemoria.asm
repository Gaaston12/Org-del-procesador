;PROGRAMA: Se puede observar que al mover un label al registro eax, los siguientes labels se colocarán de manera automática también en el mismo. En este caso, se hace mov eax, [l1].

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
						;Por ejemplo para hacer uso de dump_regs, que lo que hace es imprimir el estado de los
						;registros por pantalla
segment .data
l1 db 5;				;Declaro un label de tipo byte y le asigno el valor 5 en decimal
l2 dw 1;
l3 db 2;
l4 db 3;
l5 db 4;
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
;-------------------------------------------------------------

	mov eax, 0		;Es para rellenar todo eax con ceros
	mov eax, [l1]	;eax=02000105 (05 tipo byte + 0001 typo word + 02 tipo byte)	
	dump_regs 1		;Imprime por pantalla lo que contienen los registros

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 