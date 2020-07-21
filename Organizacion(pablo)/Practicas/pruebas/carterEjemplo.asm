; Archivo: first.asm
; Primer programa en ensamblador. Este programa pide dos
; enteros como entrada e imprime su suma
; Para crear el ejecutable usando djgpp:
;
; nasm -f coff first.asm
; gcc -o first first.o driver.c asm_io.o

%include "asm_io.inc"
;
; Los datos iniciados se colocan en el segmento .data
;
segment .data
;
; Estas etiquetas se refieren a las cadenas usadas para la salida
;
prompt1 db "Digite un número: ", 0 ;no olvide el fin de cadena
prompt2 db "Digite otro número: ", 0

outmsg1 db "Ud. ha digitado ", 0
outmsg2 db " y ", 0
outmsg3 db ", la suma es ", 0

;
; Los datos no iniciados se colocan en el segmento .bss
;
segment .bss
;
; Estas etiquetas senalan a palabras dobles usadas para almacenar los datos
; de entrada
;
input1 resd 1
input2 resd 1

;
; El código se coloca en el segmento .text
;
segment .text

global asm_main
asm_main:

	enter 0,0	; setup routine
	pusha

	mov	eax, prompt1
	call print_string 	; print out prompt
	
	call read_int		; lee un entero
	mov	[input1], eax 	; lo almacena en input1 
	
	
	mov eax, prompt2	; print out prompt 
	call print_string  
	
	call read_int		; lee un entero
	mov [input2], eax 	; lo almacena en input2	
	
	
	mov eax, [input1]	; eax = dword en input1
	add eax, [input2]	; eax += dword en input2
	mov	ebx, eax 	  	; ebx = eax
	
	
	
	

	dump_regs 1			; imprime los valores de los registros
	dump_mem 2, outmsg1, 1	; imprimer la memoria

	;
; ahora, se imprimen los resultados en una serie de pasos
;
	mov eax, outmsg1

	call print_string 		;se imprime el primer mensaje
	mov	eax, [input1]
	
	call print_int 			;se imprime input1
	
	mov eax, outmsg2
	
	call print_string		;se imprime el segundo mensaje
	mov eax, [input2]
	
	call print_int			;se imprime input2
	
	
	mov eax, outmsg3
	
	call print_string		;se imprime el tercer mensaje
	mov	eax, ebx
	call print_int			;se imprime la suma (ebx)
	call print_nl			;se imprime una nueva linea

	popa
	mov eax, 0				; retorna a C
	leave
	ret
	

	
	