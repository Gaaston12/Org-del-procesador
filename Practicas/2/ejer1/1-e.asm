;Multiplicar el valor 52 almacenado en una etiqueta en formato hexadecimal, con el valor
;cuya dirección de memoria está almacenada en el registro EBX.
%include "asm_io.inc"
section .data
    label1 db 34h;52 en decimal
section .text
    global asm_main
asm_main:
    mov eax, [label1]
    mov ebx, 2
    mul ebx ;mul recibe un reg, al contenido lo multiplica por eax y guarda el resu en eax
    dump_regs 1

ret

;Register Dump # 1
;EAX = 00000068 EBX = 00000002 ECX = FE364C9C EDX = 00000000
;ESI = F7F7B000 EDI = F7F7B000 EBP = FFD9D458 ESP = FFD9D43C
;EIP = 56642209 FLAGS = 0202   