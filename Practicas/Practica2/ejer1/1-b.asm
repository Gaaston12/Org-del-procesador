;Cargar el registro EBX con el decimal 18 utilizando una etiqueta label binaria.
%include "asm_io.inc"
section .data
    label1 dw 18
section .text
    global asm_main
asm_main:
    mov ebx, 0
    dump_regs 1
    mov ebx, [label1]
    dump_regs 2
ret

;Register Dump # 1
;EAX = 56589000 EBX = 00000000 ECX = 74B720D4 EDX = FF99EE34
;ESI = F7EEB000 EDI = F7EEB000 EBP = FF99EE08 ESP = FF99EDEC
;EIP = 56586202 FLAGS = 0216             AF PF   
;Register Dump # 2
;EAX = 56589000 EBX = 00000012 ECX = 74B720D4 EDX = FF99EE34
;ESI = F7EEB000 EDI = F7EEB000 EBP = FF99EE08 ESP = FF99EDEC
;EIP = 5658620F FLAGS = 0216             AF PF