;Pablo Etcheverry
;etcheverrypablol@gmail.com
;githug: etcheverrypablol
;21-10-16
;PROGRAMA: Construya un programa assembler que calcule el factorial de un número dado. (resuelva de manera iterativa).

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
msg_program	db	"PROGRAMA: Calcula el factorial de un número natural.", 0
msg_imput 	db 	"Ingrese un número", 0

segment .bss
num resw	1	;Lugar para almacenar el número

segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, msg_program		;Mensaje que dice lo que hace el programma
	call print_string			;Imprime la cadena que esta en eax
	call print_nl
	mov eax, msg_imput			;Mensaje que pide el numero al usuario
	call print_string			;Imprime la cadena que está en eax
	call print_nl

	call read_int
	mov [num], eax				;Almacena el número ingresado en num
	
	mov ecx, 0					;Para dejar todo ecx con ceros
	mov cx, [num]				;Es el numero que va a ir decrementando el loop
	
	mov eax, 1					;Es donde se va a ir almacenando el factorial
	jmp factorial				;Hace el salto hacia la etiqueta jmp

factorial: 
	imul ax, [num] 				;Multiplica ax, con el número y lo almacena en eax
	sub word [num], 1			;[num]= [num] -1

	loop factorial 				;ecx=ecx-1

	call print_int				;Imprimo el entero que está en eax. Recordar que aquí estaba almacenada la multiplicación

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 