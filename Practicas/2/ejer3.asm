;Determine cómo simuları́a los esquemas de las estructuras de control
;(comparaciones, saltos condicionales y ciclos) en assembler

%include "io.inc"

;se defininen las variables
section .data

section .bss
    
section .text
global CMAIN
CMAIN:

;if EAX == 0
;   EBX =1;
;else
;   EBX =2;
        cmp eax, 0
        jz thenblock
        mov ebx, 2
        jmp next
    thenblock:
        mov ebx, 1
    next:

;ciclo for
;sum = 0;
;for(i=10;i>0;i--)
;   sim+=i;
        mov eax, 0 
        mov ecx, 10
    for_loop:
        cmp ecx, 0
        jz end_loop
        add eax, ecx
        dec ecx
        jmp for_loop
    end_loop:


ret