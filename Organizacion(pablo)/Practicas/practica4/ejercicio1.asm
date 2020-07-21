;Pablo Etcheverry
;etcheverrypablol@gmail.com
;githug: etcheverrypablol
;22-10-16
;PROGRAMA: Hace uso de la subrutina print_hex que imprime un número en hexadecimal
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
msg_program		db 		"PROGRAMA: convierte un número ingresado en hexadecimal", 0
msg_imput		db 		"Ingrese un número: ", 0

msg_output1		db 		"El numero ", 0
msg_output2     db  	" en hexadecimal es: ", 0
segment .bss
num resb 1 			 	;Reserva 1 byte de memoria con el nombre num


segment .text
	global asm_main
asm_main:
	enter 0, 0				;
	pusha

	mov eax, msg_program 	;Dice lo que hace el prorgrama
	call print_string		;Imprime la cadena que está en eax
	call print_nl			;Imprime un salto de línea

	mov eax, msg_imput 		;Pide al usuario un número
	call print_string 		;Imprime la cadena que está en eax
	call print_nl			;Imprime el salto de línea

	call read_int			;Lee un entero desde el teclado y lo almacena en eax
	mov [num], eax 			;Guarda en num el número que se ingresó desde el teclado

	mov eax, msg_output1 	;Mueve a eax una de las cadenas para mostrar el resultado 
	call print_string 		;Imprime la cadena que está en eax
	mov eax, [num]			;Mueve a eax el numero ingresado
	call print_int 			;Imprime el número ingresado
	mov eax, msg_output2 	;Mueve a eax la otra cadena para mostrar el resultado
	call print_string 		;Imprime la cadena 

	mov eax, 0				;Coloco eax con todos ceros
	mov al, [num]			;Muevo a al, ya que num ocupa 1byte
	call print_hex 			;Llamo a la subrutina que está definida en el archivo asm_io.asm
							;y que imprime un número en formato hexadecimal

	popa	 				;Saca los registros de la pila
	mov	eax,0 				;retornar a C
	leave
	ret
;fin del programa 