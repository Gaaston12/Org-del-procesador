%include "asm_io.inc"

section .data
    label18 dd 010010b
    labelD dd 0
    label52 dd 34h
section .bss
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;a) Incrementar el valor del registro EAX.
    inc eax
    
    ;b)Cargar el registro EBX con el decimal 18 utilizando 
    ;una etiqueta label binaria.
    mov ebx, [label18]
    
    ;c)Sumar al registro EAX el valor 200 (expresado en decimal).
    add eax, 200
    
    ;d)Cargar el registro AX (parte baja del registro EAX) 
    ;con el contenido de la celda de memoria cuya direcci�n 
    ;est� almacenada en el registro EBX.
    mov ebx, labelD 
    mov ax,[ebx]
    
    ;e)Multiplicar el valor 52 almacenado en una etiqueta en 
    ;formato hexadecimal,con el valor cuya direcci�n de 
    ;memoria est� almacenada en el registro EBX.
    mov eax, [label52]
    mov ebx, 2
    mul eax ;eax= eax * ebx (52 * 2)->eax
    
    ;f)Sumar al registro EAX el contenido de la celda de 
    ;memoria cuya direcci�n es calculada incrementando 
    ;el registro EBX en 4 unidades.
    inc ebx
    inc ebx
    inc ebx
    inc ebx
    add eax,ebx
    ret