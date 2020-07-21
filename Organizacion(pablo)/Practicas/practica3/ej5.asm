;PROGRAMA: Se declaran 3 arreglos con elementos de distintos tamaños 
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
arre_byte	db 	0, 1, 2		;Arreglo cuyos elementos son de tipo byte
arre_word	dw 	0, 1, 2		;Arreglo cuyos elementos son de tipo word(2 bytes)
arre_dword	dd 	0, 1, 2		;Arreglo cuyos elementos son de tipo double word (4 bytes)

msg_byte	db 	"ARREGLO DE ELEMENTOS DE TAMAÑO BYTE", 0
msg_word	db 	"ARREGLO DE ELEMENTOS DE TAMAÑO WORD", 0
msg_dword	db 	"ARREGLO DE ELEMENTOS DE TAMAÑO DOUBLE WORD", 0
segment .bss


segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha
;_________________________________________________________________________________________________________
;Arreglo de bytes. OBSERVAR que se suma +1 ya que los elementos son de 1 byte
	mov eax, msg_byte		;Muevo en eax la cadena que dice que es el arreglo de bytes
	call print_string		;Imprimo la cadena que está en eax
	call print_nl			;Hacemos un salto de línea
	mov eax, 0				;Para colocar eax con ceros
	mov al, [arre_byte]		;Como [arre_byte] ocupa sólo un byte, lo guardo en al
	call print_int			;Imprimo por pantalla lo que contiene eax

	mov al, [arre_byte+1]	;Como [arre_byte+1] ocupa sólo un byte, lo guardo en al
	call print_int			;Imprimo por pantalla lo que contiene eax

	mov al, [arre_byte+2]	;Como [arre_byte+2] ocupa sólo un byte, lo guardo en al
	call print_int			;Imprimo por pantalla lo que contiene eax
	call print_nl			
;_________________________________________________________________________________________________________
;OBSERVAR que se suma +2 ya que los elementos son de 2 bytes
	mov eax, msg_word 		;Muevo en eax la cadena que dice que es el arreglo de word
	call print_string		;Imprimo la cadena que está en eax
	call print_nl			;Imprimo el salto de línea	
	mov eax, 0				;Para colocar eax con todos ceros
	mov ax, [arre_word]		;Muevo en ax, ya que el arrglo tiene elementos de 2 bytes
	call print_int			;Imprimo el primer elemento

	mov ax, [arre_word+2]	;Muevo el segundo elemento del arreglo de tipo word
	call print_int			;imprimo el segundo elemento

	mov ax, [arre_word+4]	;Muevo el tercer elemento del arreglo
	call print_int			;Imprimo el tercer elemento 
	call print_nl
;_________________________________________________________________________________________________________
;OBSERVAR que se suma +4 ya que los elementos son de 4 bytes
	mov eax, msg_dword			;Muevo en eax la cadena que dice que es el arrelgo de double word
	call print_string			;Imprimo la cadena que estoy en eax
	call print_nl

	mov eax, [arre_dword]		;Muevo en eax el primer elemento del arreglo que es de 4 bytes
	call print_int				;Imprimo el primer elemento del arreglo

	mov eax, [arre_dword+4]		;Muevo en eax el segundo elemento del arreglo que es de 4 bytes
	call print_int

	mov eax, [arre_dword+8]		;Muevo en eax el tercer elemento del arreglo que es de 4 bytes
	call print_int

;________________________________________________________________________________________________	
	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 