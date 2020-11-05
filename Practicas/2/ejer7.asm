;construya un porgrama assembler que calcule el factorial de un numero dado.
;resuelva de manera iterativa.
%include "asm_io.inc"

section .data
section .bss

section .text
global CMAIN
CMAIN:

    xor eax, eax
    mov ecx, 5
    mov eax, ecx
    while:
        cmp ecx, 1
        jle endWhile
        sub ecx, 1
        mul ecx
        jmp while
    endWhile:
    call print_int
    call print_nl
    ;dump_regs 222 ;en eax esta el resultado

ret

;compilacion:
;   nasm -f elf ejer6.asm			                    (genera el .o del archivo)
;   nasm -f elf -d ELF_TYPE asm_io.asm	                		    (genera el .o de la libreria)
;   gcc -o sumaPares driver.c ejer6.o asm_io.o -m32	    (genera un a.out que es el ejecutable)
;   ./sumaPares