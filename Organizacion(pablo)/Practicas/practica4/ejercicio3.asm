;Pablo Etcheverry
;etcheverrypablol@gmail.com
;githug: etcheverrypablol
;25-10-16
;PROGRAMA: Realice un subrutina en assembler que calcule el mayor de dos números enteros. 
;Utilice la misma para calcular el mayor valor de un arreglo de 10 elementos declarado en el segmento data.

%include "asm_io.inc"	;Biblioteca que se incluye para hacer uso de macros que sirven para depurar el programa

segment .data
msg_program 	db 	"PROGRAMA: Calcula el máximo de un arreglo de 10 números declarado en .data", 0
msg_array1 		db  "El arreglo cargado es: ", 0
msg_array2 		db 	" ", 0
msg_output 		db 	"El máximo número del arreglo es: ", 0

array_int 		db  2,0,5,4,10,5,6,11,8,0
last 			db 10
segment .bss
maximo  resw 	1				;Para guardar el máximo de todos los números
 			
segment .text
	global asm_main
asm_main:
	enter 0, 0					;Código de rutina  
	pusha 						;Carda los registros a la pila

	mov eax, msg_program 		;Cadena que dice lo que hace el programa
	call print_string			;Imprime la cadena que está en eax
	call print_nl 				;Imprime un salto de línea
	
	mov eax, msg_array1 		;Cadena para mostrar el arreglo
	call print_string			;Imprime la cadena que está en eax
	call print_nl  				;Imprime un salto de línea

	call print_array 			;Subrutina que muestra el arreglo
	call print_nl	 			
	mov ecx, 0 					;Para colocarle todos ceros. Este registro decrementa el loop
	mov cl, [last]				;Coloco en cl el número de elementos del arreglo. last es tipo byte
	sub ecx, 1 					;Le resto 1, ya que coloco el primer elemento en eax
	mov eax, 0 					
	mov al, [array_int] 		;Muevo a al el primer elemento del arreglo. En al, ya que es de 1 byte
	mov edx, 1					;Es como el índice para ir accediendo al arreglo. Ya le paso el segundo
								;Primero se comparan el 1ro y el 2do, y luego con el 3ro, 4to, etc 
loop_max:
	mov ebx, 0 					;Es para colocar el siguiente elemento del arreglo
	mov bl, [array_int+edx] 	;Se coloca el siguiente elemento del arreglo
	push eax					;Coloca en la pila uno de los parámetros que precisa max
	push ebx 					;Coloca en la pila el otro parámetro
	call max    				;Llama a max
	add esp, 8 					;Responsabilidad del invocante de eliminar los 2 parámetros subidos a la pila
	add edx, 1 					;El arreglo contiene elementos de a bytes
		loop loop_max	

	mov ebx, eax 				;Guardo el mayor en ebx, ya que voy a usar eax
	mov eax, msg_output 		;Cadena para mostrar el resultado
	call print_string   
	mov eax, ebx        		;Coloco en eax el mayor 
	call print_int	
	popa 							
	mov	eax,0 	;retornar a C
	leave
	ret

;Subrutina que calcula el máximo de dos numeros enteros que se le pasa como parámetro
max:
	push ebp 					;Almacena el ebp viejo 
	mov ebp, esp				;Actualiza el ebp
	push ecx 					;Antes del llamado de max, se está usando ecx, por lo que lo guardo en la pila

	mov ecx, [ebp+8]			;Mueve ecx uno de los parámetros
	cmp ecx, [ebp+12] 			;Compara un parámetro con el otro 
	jg mayor_ecx 				;Salta si vleft>vrigth
	mov eax, [ebp+12]			;En caso de que no salte almaceno en el mayor de ellos
	jmp fin
mayor_ecx:
	mov eax, [ebp+8]
								;Observar que el mayor de los números queda almacenado en eax
fin:
	pop ecx 					;Actualizo el registro ecx con el valor que tenía antes
	pop ebp 					;Actualiza el ebp para que retornde donde estaba antes del llamado de la rutina
	ret 						;Retorna a la siguiente instrucción

;Subrutina que imprime un arreglo
print_array:
  push ebp
  mov ebp, esp

  mov ecx, 0
  mov cl, [last]
  mov edx, 0
  jmp print
 print:
 	mov eax, 0
 	mov al, [array_int+edx]
 	call print_int
 	mov eax, msg_array2
 	call print_string
 	add edx, 1
 	loop print
  pop ebp
  ret

