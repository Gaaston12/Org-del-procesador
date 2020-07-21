%include "asm_io.inc"

segment .data	;Lugar donde se declaran las variables inicializadas
l1 db 18
l2 db 200
l3 db 0
l4 dw 34h		;52 almacenado en formato hex
segment .bss	;Lugar donde se declaran las variables no inicializadas. Por lo general se hace uso del res
	 
segment .text	;Es donde comienza el código

global asm_main

asm_main:

	enter 0,0 ;Hace referencia a la pila
	pusha	;Colcoca en la pila el estado actual del invocante. El estado de los registros y el IP. Esto lo hace para recordar el estado del invocante, es decir, el estado del programa, que luego va a llamar a un subprograma. En la pila se guarda una direccion de memorio (Pasaje por refeerencia), o un valor temporal que luego desaparece(Pasaje por valor)

;---------------------------------------------------------------------------------------------------
;Ej 1a)
	;inc EAX 		;Incrementa el valor del registro EAX
;---------------------------------------------------------------------------------------------------
;Ej 1b)	
	;mov EBX, [l1]	;Coloco en EBX lo que está en l1
;---------------------------------------------------------------------------------------------------
;Ej 1c)	
	;mov EAX, [l3]	;Coloco en EAX el valor 0, para luego sumarle algo	
	;add EAX, [l2]	;EAX = EAX + 200. También se puede hacer add eax 200, donde 200 es un operando inmediato
;---------------------------------------------------------------------------------------------------
;Ej 1d)	
	;mov AX, [ebx]	;Me tira error cuando quiero hacer mov AX, EBX y también con mov AX [EBX]
					;Análisis del error: Si yo en el Ej 1b) hago mov ebx, l1 entonces guardo en ebx la dirección de memoria de l1 (que es de 8 bit), por lo tanto queda en ebx 8 bits, que posteriormente los voy a poder pasar a ax que tiene 16 bits. Por otro lado, si hago mox ebx, [l1] donde l1=19, guardo en ebx el número 18 y al hacer mov ax, [ebx] estaría queriendo guardar en ax la dirección de memoria nro 18 del sistema, que es muy probable que el sistema operativo no me permita acceder.
;---------------------------------------------------------------------------------------------------
;Ej 1e)	Multiplico el contenido de la etiquta l4 que tiene el 52 en exadecimal por el contenido que tiene ebx

		
	mov ax, [l4]	;ax= 52	en decimal
	mov ebx, 2 		;ebx= 2 en decimal
	mul	bx			;eax =bx*ax
	
;---------------------------------------------------------------------------------------------------
;Ej 1f)
	;mov EBX, l1		;Le asigno a ebx una dirección de memoria de un leabel, que es una dirección que ya hemos reservado
	;add eax, [ebx + 4]	

	dump_regs 332 	;Lo que hace es usar internamente el printf. Imprime el valor en Hexadecimal de los registros

	;call print_int ;imprime solo el valor de EAX 
	popa		;Saca todo lo que está en la pila 
	mov eax, 0	;Lo que dice es que todo está OK, como el return 0 en C. Es para decirle al que lo invocó que está todo bien
	leave		;
ret