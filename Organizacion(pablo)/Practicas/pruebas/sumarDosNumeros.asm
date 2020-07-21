;PROGRAMA: Se suman dos números. Hay que tener en cuenta que los labels se tienen que mover en las partes indicadas de los registros. Si movemos un label que ocupa un byte a eax, deberíamos moverlo a al, y no a eax completo, ya que al hacerlo, estaríamos trayendo los demás labels tambien al registro. 

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa
						;Por ejemplo para hacer uso de dump_regs, que lo que hace es imprimir el estado de los
						;registros por pantalla
segment .data
l1 db 5;				;Declaro un label de tipo byte y le asigno el valor 5 en decimal
l2 dw 2000;				;Declaro un label de tipo word (2 bytes) y le asigno el valor 2000 en decimal
l3 dd 2;
l4 dd 3;
l5 dd 4;
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
;-------------------------------------------------------------

	mov eax, 0		;Es para rellenar todo eax con ceros
	mov al, [l1]	;al=[l1] Elijo sólo al, ya que l1 ocupa 1 byte	
	add ax, [l2]	;ax=ax+[l2] Elijo ax, ya que l2 ocupa 2 bytes. Si elijo al, el resultado en eax no es correcto
	
	dump_regs 1		;Imprime por pantalla el valor de los registros
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 