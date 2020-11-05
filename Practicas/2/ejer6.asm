; Integrantes:
;
;
;   Gaston Martin

%include "io.inc"

section .data
    a1 dd 1,2,3,4,5,6,7,8,9,10
    aux dd 0    
section .bss
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp                ; for correct debugging
    mov eax, a1
    xor ebx, ebx                ;"i" recorre el arreglo
    xor ecx, ecx                ;iterador
    xor edx, edx                ;suma de los pares
    while:
        cmp ecx, 10
        je endWhile
        mov eax, [a1 + ebx]
                                ;if para ver si es par
            mov [aux], eax      ;guardo el valor de eax para no perderlo
            and eax, 1          
            cmp eax, 0          ;si es 0 el numero es par  
            jpe es_par          ;si es 0 salta y suma
            jmp next            ;sino sale del if y sigue con el recorrido del arreglo
            es_par:
                mov eax, [aux]
                add edx, eax
            next:
        mov eax, [aux]            
        add ebx, 4 
        inc ecx
        jmp while
    endWhile:
    mov eax, edx
    call print_string           ;muestra por pantalla el valor de la suma
ret