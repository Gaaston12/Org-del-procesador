;Escriba un programa en assembler que utilice tres arreglos definidos en el segmento
;de datos, pero cada uno con un tamaño diferente de elementos (byte, word, dword).
;Determine cuántos bytes se necesitan para obtener cada elemento de estos
;arreglos. Realice un programa en assembler que muestre los elementos de los tres arreglos.
%include "asm_io.inc"

section .data
a1 db "hello, world",0
a2 dd 1,2,3,4,5,6,7,8,9,10
a3 dw "a","b","c","d"


section .bss
    
section .text
global CMAIN
CMAIN:

;arreglo 2
        mov eax, a2
        xor ebx, ebx 
        xor ecx, ecx 
    while:
        cmp eax, 10
        je endWhile
        mov eax, [a2 + ebx]
        add ebx, 4 
        inc ecx
        call print_string
        jmp while
    endWhile:


;arreglo 1
      ;  mov eax, a1
       ; xor ebx, ebx 
        ;xor ecx, ecx 
    ;while2:
    ;    cmp eax, 10
    ;    je endWhile2
    ;    mov eax, [a1 + ebx]
    ;    add ebx, 2
    ;    inc ecx
    ;    jmp while2
   ; endWhile2:

ret
