;Pablo Etcheverry
;etcheverrypablol@gmail.com
;githug: etcheverrypablol
;21-10-16
;PROGRAMA:

%include "asm_io.inc"	

segment .data

segment .bss


segment .text
	global asm_main
	global suma_intervalar
asm_main:
	push ebp
	mov ebp, esp	 
	pusha
	
	mov eax, 0 				; Coloco todo eax con cero
	dump_regs 0 			; Imprimo los registros
	mov eax, [ebp+20] 		; Coloco en eax el segundo parámetro que subí
	call print_int 			; Imprimo el número que está en eax
	call print_nl 			; Salto de línea


	mov eax, [ebp+24] 		; Coloco en eax el segundo parámetro
	call print_int 			; Imprio el numero que está en eax
	call print_nl 			; Salto de línea


	mov eax, [ebp+28] 		; Coloco en eax el segundo parámetro que subí
	call print_int 			; Imprimo el número que está en eax
	call print_nl 			; Salto de línea

	mov eax, [ebp+32] 		; Coloco en eax el segundo parámetro
	call print_int 			; Imprio el numero que está en eax
	call print_nl 			; Salto de línea




	popa
	leave
	ret

;####################################################################################

suma_intervalar: 
	push ebp
	mov ebp, esp

	mov eax, 0 				; Coloco todo eax con cero
	dump_regs 0 			; Imprimo los registros
	mov eax, [ebp+8] 		; Coloco en eax el segundo parámetro que subí
	call print_int 			; Imprimo el número que está en eax
	call print_nl 			; Salto de línea


	mov eax, [ebp+12] 		; Coloco en eax el segundo parámetro
	call print_int 			; Imprio el numero que está en eax
	call print_nl 			; Salto de línea


	mov eax, [ebp+16] 		; Coloco en eax el segundo parámetro que subí
	call print_int 			; Imprimo el número que está en eax
	call print_nl 			; Salto de línea

	mov eax, [ebp+20] 		; Coloco en eax el segundo parámetro
	call print_int 			; Imprio el numero que está en eax
	call print_nl 			; Salto de línea


; Acomodo los dos números intervalares en eax y ebx


	mov eax, [ebp+8]
	shl eax, 16
	mov ebx, [ebp+12]
	mov ax, bx

	mov ebx, [ebp+16]
	shl ebx, 16
	mov ecx, [ebp+20]
	mov bx, cx
	dump_regs 1

; Sumo Parte Inferiores y Superiores y las dejo en eax
	add eax, ebx
	dump_regs 2	

	mov [ebp+32], eax 		;Dejo en el ultimo parámetro que se sube a la pila, el resultado

	mov esp, ebp
	pop ebp
	ret

;fin del programa 351 509





