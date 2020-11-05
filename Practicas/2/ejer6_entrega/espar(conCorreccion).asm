%include "asm_io.inc"
section .data
pair dd 1b ; mascara
cadPAR db "\ PAR \",0
cadIMPAR db "\ IMPAR \",0
frase db "SUMA DE NUMEROS PARES:",0
arre dw 2,2,1,1,1,2,3,4,2,6
acumulPares dd 0
section .text
global CMAIN
CMAIN:
mov ecx,10
xor ebx,ebx
mov edx,0 ;iterador
loop_start:
    xor eax,eax
    mov ax,[arre + edx] ;ir modficando los valores, para probar el programa
    mov ebx, eax ; va ayudar a acumular la suma de pares
    ;add edx,2
    test eax, [pair]
    jz THEN_IF
    jmp FIN
    THEN_IF:
     mov eax,cadPAR
     call print_string 
     add [acumulPares],ebx ; acumla numeros pares
     add edx,2
     jmp next
    FIN:
     mov eax,cadIMPAR
     call print_string 
     add edx,2
     jmp next
     next:
     loop loop_start
     mov eax,frase
     call print_string
     xor eax,eax
     mov eax,[acumulPares]
     call print_int
    ret


