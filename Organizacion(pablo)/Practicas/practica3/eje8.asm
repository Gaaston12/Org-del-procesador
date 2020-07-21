;Pablo Etcheverry
;etcheverrypablol@gmail.com
;githug: etcheverrypablol
;21-10-16
;PROGRAMA: Construya un programa assembler que dado un número entero positivo N, calcule la serie de fibonacci hasta N y la muestre por pantalla (resuelva de manera iterativa). Ejemplo: La serie de fibonacci para n = 6 es 11235

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
msg_program 	db 	"PROGRAMA: Calcula el Fibonacci de un número.", 0
msg_imput		db 	"Ingrese un número natural: ", 0
msg_result1		db	"El fibonacci de: ", 0
msg_result2 	db 	" es ", 0

segment .bss
num resw	1		;Es donde se almacena el número
fib1 resw 	1
fib2 resw 	1

segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, msg_program
	call print_string	
	call print_nl

	mov eax, msg_imput
	call print_string
	call print_nl

	call read_int
	mov [num], eax

	cmp word [num], 0
	jz fin_program0
	cmp word [num], 1
	jz fin_program1
							;EN CASO DE QUE SE HAYA INGRSADO num>1
	mov ecx, [num]			;Registro que va a decrementar el loop
	sub ecx, 1				;Ya que hay numeros que ya se suman
	mov ebx, 0				;Registro donde se va a almacenar le sucesion
	mov word [fib1], 0
	mov word [fib2], 1
	jmp fibonacci
fibonacci:
	mov ax, 0
	add ax, [fib1]
	add ax, [fib2]
	add bx, ax				;Es donde se va almacenar la sucesion
	mov dx, word [fib2]
	mov word [fib1], dx
	mov word [fib2], ax
	loop fibonacci

	mov ebx, eax
	mov eax, msg_result1	
	call print_string
	mov eax, 0
	mov ax, [num]
	call print_int
	mov eax, msg_result2	
	call print_string
	mov eax, ebx
	call print_int	
	jmp fin
fin_program0:
	mov eax, 0
	call print_int
	jmp fin
fin_program1:
	mov eax, 1
	call print_int
	call print_nl
	jmp fin


fin:

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 