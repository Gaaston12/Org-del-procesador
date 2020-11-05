;Sumar al registro EAX el valor 200 (expresado en decimal).
%include "asm_io.inc"
section .data
    
section .text
    global asm_main
asm_main:
    mov eax, 0
    dump_regs 1
    add eax, 200
    dump_regs 2
ret