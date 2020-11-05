;Cargar el registro AX (parte baja del registro EAX) con el contenido de la celda de memoria
;cuya dirección está almacenada en el registro EBX.
%include "asm_io.inc"
section .data
    
section .text
    global asm_main
asm_main:
    mov ax,[ebx]
    dump_regs 2
ret