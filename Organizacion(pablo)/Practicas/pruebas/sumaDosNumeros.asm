%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
prompt1 db "Digite un número: ", 0 			;Primer texto que se imprime por pantalla	
prompt2 db "Digite otro número: ", 0 		;Segundo texto que se imprime por pantalla	

outmsg1 db "Usted ha ingresado ", 0			;Para mostrar el resultado de la suma
outmsg2 db " y ", 0							;
outmsg3 db ". La suma es: ", 0				;

segment .bss

imput1 resd 1				;Para almacenar el primer número que se ingrese
imput2 resd 2				;Para almacenar el segundo número que se ingrese
segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha
;--------------------------------------------------------------------------------------------------------
;Se pide el ingreso de los datos
	mov eax, prompt1		;Muevo en eax la dirección de memoria de prompt1. Para imprimir por pantalla usar eax.
	call print_string		;Imprime por pantalla lo que contiene eax
	call read_int			;Lee un entero y lo almacena en eax
	mov [imput1], eax		;Coloca en imput1 lo que contiene eax
	
	mov eax, prompt2	
	call print_string
	call read_int
	mov [imput2], eax

	mov eax, [imput1]		;Muevo en eax el primer número
	add eax, [imput2]		;Sumo el primer número con el segundo y lo dejo en eax

	mov ebx, eax			;Dejo guardado el resultado en este registro, ya que voy a precisar usar eax
	dump_regs 0				;Imprime el valor de los registros
	;dump_mem 2, outmsg1, 1	;Esto es para mostrar información sobre la memoria
	
;Ahora se muestra el resultado de la suma
	
	mov eax, outmsg1		;Muevo en eax la cadena: "Usted ha ingresado", 0
	call print_string		;Imprimo lo que hay en eax
	mov eax, [imput1]		;Muevo en eax el primer número que se ha ingresado
	call print_int			;Imprimo el entero que tiene eax. Observar que es prin_int y no print_string

	mov eax, outmsg2		;Muevo en eax la cadena: " y ", 0
	call print_string		;Imprimo la cadena que hay en eax
	mov eax, [imput2]		;Muevo en eax el segundo número que se ha ingresado
	call print_int			;Imprimo el número que hay en eax
	
	mov eax, outmsg3		;Muevo en eax la cadena: " La suma es: ",0
	call print_string		;Imprimo la cadena que hay en eax
	mov eax, ebx			;Muevo en eax el resultado de la suma
	call print_int			;Muestro por pantalla el resultado de la suma
	call print_nl
;-------------------------------------------------------------------------------------------------------

	popa
	mov	eax,0 	;retornar a C
	leave
	ret
;fin del programa 