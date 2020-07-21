%include "asm_io.inc"
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
;El código será colocado en el segmento de texto. No 
;modifique el código antes o despues de este comentario
;
;------------------------------------------------------
;Extender el registro ax a eax cuando tiene numeros positivo con el comando MOVZX

	;mov ax, 34h		;ax=52 (almacenado en 16 bits)
	;mov cl, al 		;cl= los 8 bits inferiores de ax
	;movzx eax, ax 	;extiende ax en eax, y coloca
;------------------------------------------------------
;Extender el registro ax a eax cuando tiene números negativos con el comando CWDE
	
	mov ax, -34h		;ax = -52 
	cwde 				;extiende ax en eax para números con signos
	;movsx eax, ax		;Trabaja como movzx excepto que usa las reglas para números con signo
	dump_regs 332
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 