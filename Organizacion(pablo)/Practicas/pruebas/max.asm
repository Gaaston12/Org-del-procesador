;PROGRAMA: Calcula el máximo entre dos números
%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
msg_1  db  "Ingrese el primer número: ", 0
msg_2  db  "Ingrese el segundo número: ", 0
msg_3  db  "El mayor de los números ingresados es: ", 0
segment .bss
num1 resd 1			;Para guardar los números 
num2 resd 1 			
segment .text
	global asm_main
asm_main:
	enter 0, 0	;rutina de 
	pusha

	mov eax, msg_1 			;Cadena para pedir al usuario el primer número
	call print_string 		;Imprime la cadena de eax
	call print_nl  			;Imprime el salto de línea

	call read_int   		;Lee un entero desde el teclado
	mov [num1], eax  		;Coloca en num1 el numero ingresado

	mov eax, msg_2 			;Le pide al usuario que ingrese otro número
	call print_string 		;Imprime la cadena que está en eax
	call print_nl			;Imprime el salto de línea

	call read_int 			;Imrprime el número que está en eax
	mov [num2], eax 		;Coloca en num2 el segundo número

	mov eax, [num1] 		;Para subirlo en la pila
	mov ebx, [num2] 		;Para subirlo en la pila

	push ebx 				;Sube uno de los parámetros a la pila
	push eax				;Sube el otro parámetro a la pila
	call max 				;Llama a la subrutina max
	pop ebx					;Saca uno de los parámetros de la pila y lo deja en ebpx		
	pop ebx					;Saca el otro parámetro en eax, y lo pisa

	mov ebx, eax			;Guardo el mayor de los números en ebx ya que voy a usar eax
	mov eax, msg_3 			;Cadena para mostrar el resultado
	call print_string 		;Imrrime la cadena de eax
	mov eax, ebx 			;Coloca en eax el mayor número calculado
	call print_int 			;Imprime el número de eax

	popa 					;Saca todos los registros de la pila 
;	mov eax, 0 				
	leave					;Hace: mov esp, ebp y pop ebp 
	ret 					;Retorna a la siguiente instrucción

max:

	push ebp 				;Almacena el ebp viejo 
	mov ebp, esp			;Actualiza el ebp

	mov ecx, [ebp+8]		;Mueve ecx uno de los parámetros
	cmp ecx, [ebp+12] 		;Compara un parámetro con el otro 
	jg mayor_ecx 			;Salta si vleft>vrigth
	mov eax, [ebp+12]		;En caso de que no salte almaceno en el mayor de ellos
	jmp fin
mayor_ecx:
	mov eax, [ebp+8]
fin:
							;Observar que el mayor de los números queda almacenado en eax
	pop ebp 				;Actualiza el ebp para que retornde donde estaba antes del llamado de la rutina
	ret 					;Retorna a la siguiente instrucción
