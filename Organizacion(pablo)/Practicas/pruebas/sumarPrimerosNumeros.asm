;PROGRAMA: HACE LA SUMA DE LOS PRIMEROS N NÚMEROS NATURALES
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
program_msg 	db		"PROGRAMA: PIDE UN ENTERO N, Y SUMA LOS PRIMEROS N NATURALES", 0
num_msg			db		"Ingrese un número natural: ", 0
suma_msg1		db		"El resultado de los primeros ", 0
suma_msg2		db 		" números naturales es: ", 0

segment .bss
num resd 1			;label donde se va a almacenar el número que ingrese el usuario

segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, program_msg	;Coloco en eax la cadena que dice lo que hace el programa
	call print_string		;Imprime la cadena de eax
	call print_nl
	mov eax, num_msg		;Es para pedir un número al usuario
	call print_string		;Imprime la cadena de eax

	call read_int			;Almacena en eax el número ingresado por el usuario
	mov [num], eax			;Almacena el número en num

	mov eax, 0				;Es donde se va a almacenar la suma
	mov ecx, [num]			;Es lo que va a ir decreciendo	

loop_start:
	add eax, ecx 			;Suma lo que tiene eax con lo que tiene ecx
	loop loop_start			;Lo que hace loop es decrementar ecx de uno en uno. Cuando es menor que cero, salta
	mov ebx, eax			;Almacena en ebx le resultado de la suma

;_______________________________________________________________________________________________________________
;Se muestra el resultado de la suma

	mov eax, suma_msg1		;Primera parte del mensaje que dice el resultado
	call print_string		
	mov eax, [num]			;Mueve en eax la cantidad de números naturales que se están sumando
	call print_int
	mov eax, suma_msg2		;Segunda parte del mensaje que dice el resultado
	call print_string	
	mov eax, ebx			;Mueve en eax el resultado de la suma
	call print_int			

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 