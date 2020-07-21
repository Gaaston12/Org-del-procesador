;Pablo Etcheverry
;etcheverrypablol@gmail.com
;githug: etcheverrypablol
;21-10-16
;PROGRAMA: Defina cómo se puede determinar si un nÚmero es par utilizando operadores a nivel de bits.
;		   Luego, construya un programa assembler que dado un arreglo de 10 enteros de 16 bits (words),
;		   definido en el segmento .data, sume los números pares y muestre el resultado por pantalla.
;		   Nota: Revise el capítulo 5 del libro de Paul A. Carter para conocer en detalle el tratamiento
;  		   de arreglos en NASM.

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
arre_num dw  0, 1, 2, 3, 4, 5, 6, 7, 8, 9
nro_elem db  10

segment .bss


segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha
	
	mov edx, 0					;Variable de Sumatoria
	mov ecx, [nro_elem]			;El loop decrementa este registro
	mov ebx, 0					;El que va a permitir moverme en memoria

suma_pares:
	mov eax, 0					;Para dejar todo eax en cero 
	mov ax, [arre_num + ebx]	;Coloco el elemento corriente en ax
	and ax, 1					;Hago el and entre un registto y el 1. Esto da el valor que tienes el ultimo bit del número
	cmp eax, 0					;Compara lo que queda en eax con el cero
	jz sumar_par 				;Salta si zf == 1, osea, si la resta que hace el cmp == 0
	jmp fin						;Salta para no llamar de nuevo a sumar_par
sumar_par:
	add dx, [arre_num + ebx]	;A la variable sumatoria, le sumo el numero par corriente
fin:
	add ebx, 2					;Incremento +2 ya que el siguiente elemento se encuentra a dos lugares más de memoria
	loop suma_pares				;ecx=ecx -1 y llama de nuevo a sumar_par
	mov eax, 0					;Para dejar todo eax con ceros
	mov ax, dx					;Coloco en ax la sumatoria
	call print_int				;Imprimo el valor de la sumatoria
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 