;Incrementar el valor del registro EAX.
%include "asm_io.inc"
section .data

section .text
global asm_main

asm_main:
    mov eax, 0
    dump_regs 1
    inc eax
    dump_regs 2
ret

;Register Dump # 1
;EAX = 00000000 EBX = 56604000 ECX = F1154F3D EDX = FFBF28D4
;ESI = F7F15000 EDI = F7F15000 EBP = FFBF28A8 ESP = FFBF288C
;EIP = 56601202 FLAGS = 0216             AF PF   
;Register Dump # 2
;EAX = 00000001 EBX = 56604000 ECX = F1154F3D EDX = FFBF28D4
;ESI = F7F15000 EDI = F7F15000 EBP = FFBF28A8 ESP = FFBF288C
;EIP = 5660120A FLAGS = 0202  