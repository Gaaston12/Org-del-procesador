%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
message		db  "Halle primos hasta: ", 0	

segment .bss
limit	resd 1			;Halle primos hasta este número
guess 	resd 1			;La conjetura actual para el primo

segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, message
	call print_string	
	call read_int
	mov [limit], eax

	mov eax, 2
	call print_int
	call print_nl
	mov eax, 3
	call print_int
	call print_nl

	mov dword [guess], 5		; guess = 5;

while_limit:
	mov eax, [guess]
	cmp eax, [limit]
	jnbe	end_while_limit		; se usa jnbe ya que los números son sin signo

	mov ebx, 3					; ebx es factor = 3;

while_factor:
	mov eax, ebx
	mul eax						;edx:eax = eax*eax
	cmp	eax, [guess]
	jnbe end_while_factor
	mov eax, [guess]
	mov edx, 0
	div	ebx						; edx = edx:eax % ebx
	cmp	edx, 0
	je end_while_factor			

	add	ebx, 2					;factor +=2
	jmp	while_factor
end_while_factor:
	je end_if
	mov eax, [guess]
	call print_int
	call print_nl
end_if:
	add	dword [guess], 2		; guess +=2
	jmp	while_limit
end_while_limit:


	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 