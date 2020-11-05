;compilacion
;nasm -f elf ejer2.asm
;nasm -f elf -d ELF_TYPE asm_io.asm
;gcc driver.c ejer2.o asm_io.o -m32  

%include "asm_io.inc"
section .data
    a1 dd 0,1,2,3,4,5,6,7,8,9,10
	;     ^(0),^(1),^(2)...^(10) posiicones
section .text
global asm_main

asm_main:
	mov eax, a1 ;puntero
	mov ebx, 0	;iterador
	mov ecx, 0	;acumulador
while:
	cmp ebx, 10
	jg endwhile
	add ecx, [eax + (ebx * 4)]
	inc ebx
	jmp while
endwhile:
	dump_regs 1
    ret

;EAX = 56634028 EBX = 0000000B ECX = 00000037 EDX = FFBF7364
;ESI = F7EB8000 EDI = F7EB8000 EBP = FFBF7338 ESP = FFBF731C
;EIP = 56631217 FLAGS = 0202