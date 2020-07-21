;PROGRAMA: Ejemplo del libro Carter (2.1.4) Página 43. Se hace uso de la función mul
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data			;Cadenas de salida

prompt 			db		"Digite un número: ", 0
square_msg		db		"La entrada al cuadrado es: ", 0
cube_msg		db		"La entrada al cubo es: ", 0
cube25_msg		db		"La entrada al cubo 25 veces es: ", 0
quot_msg		db		"El cociente del cubo/100 es: ", 0
rem_msg			db		"El residuo del cube/100 es: ", 0
neg_msg			db		"La negación del residuo es: ", 0

segment .bss
imput resd 1			;Se reserva un lugar de memoria de tipo double (4 bytes)

segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, prompt		;Coloco en eax la cadena "Digite un número: ", 0
	call print_string	;Imprimo la cadena que se encuentra en eax

	call read_int		;Leo una entrada desde el teclado y lo guardo en eax
	mov [imput], eax	;Guardo en imput lo que se ha leído desde el teclado

	imul eax			;edx:eax=eax*eax	(Observar que sólo se guarda un 4 en la parte al de eax)
	mov	ebx, eax		;guarda la respuesta en ebx, y no se corta el número ya que es sólo un 4
	mov	eax, square_msg	;Guardo en eax la cadena "La entrada al cuadrado es: ", 0
	call print_string	;Imprimo por la cadena que está en eax
	mov eax, ebx		;Coloco el resultado de la entrada al cuadrado en eax
	call print_int		;Imprimo por pantalla el número que está en eax	
	call print_nl

	mov ebx, eax		;Coloco la entrada al cuadrado en eax
	imul ebx, [imput]	;ebx=ebx*[imput]
	mov eax, cube_msg 	;Coloco en eax la cadena "La entrada al cubo es: ", 0
	call print_string	;Imprimo por pantall la cadena en eax
	mov eax, ebx		;Coloco en eax la entrada al cubo
	call print_int		;Imprimo el entero que está en eax
	call print_nl		;Imprimo un salto de línea

	imul ecx, ebx, 25	;ecx = ebx*25	ebx= la entrada al cubo. (Observar que imul puede recibir tres parámetros!!)
	mov eax, cube25_msg	;Coloco en eax la cadena "La entrada al cubo 25 veces es: ", 0
	call print_string	;Imprimo la cadena que hay en eax
	mov eax, ecx		;Muevo la multiplicación a eax
	call print_int		;Imprimo el entero que hay en eax
	call print_nl		;Imprimo un salto de línea
		
	mov eax, ebx		;Coloco en eax la entrada al cubo	
	cdq					;extiende eax en edx:eax. Luego edx:eax queda con la entrada al cubo.	
	mov ecx, 100		;no puede dividirse por el valor inmediato
	idiv ecx 			;edx:eax / ecx
						;Si la fuente es de 32 bits,entonces edx:eax se divide por el operando y el
						;cociente se almacena en eax y el residuo en edx
	mov ecx, eax		;Guarda el cociente en ecx
	mov eax, quot_msg	;Coloco en eax la cadena "El cociente del cubo es: ", 0
	call print_string	;Imprimo la cadena que está en eax
	mov eax, ecx 		;Coloco en eax el cociente
	call print_int		;Imprimo el entero que está en eax
	call print_nl		;Imprimo el salto de línea

	neg edx 			;Niega el residuo de la división
	mov eax, neg_msg 	;Colocon en eax "La negación del residuo es: "
	call print_string	;Imprimo por pantalla la cadena que está en eax
	mov eax, edx 		;Muevo en eax el residuo de la división
	call print_int		;Imprimo el entero que está en eax
	call print_nl		;Imprimo por pantalla un salto de línea

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 