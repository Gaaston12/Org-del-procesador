;Sumar al registro EAX el contenido de la celda de memoria cuya dirección es calculada
;incrementando el registro EBX en 4 unidades.

%include "asm_io.inc"
section .data
    a1 dd 1,2,4,8,16,32
section .text
    global asm_main
asm_main:
    mov eax, 0
    mov ebx, a1
    add eax, [ebx + 4]
    dump_regs 1
ret