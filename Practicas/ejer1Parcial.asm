%include "asm_io.inc"

section .data
section .bss

section .text
global CMAIN
CMAIN:


    mov eax, 4  ; numero a determinar
    push eax    ;parametro
    Multi:
        cmp [ebp + 4], 3
        jnz noEsMultiplo
        mov eax, 1  ;es smultiplo
        noEsMultiplo:
        mov eax, 0  ;no es multiplo
    ret
ret