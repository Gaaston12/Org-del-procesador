; Trabajo Final de la materia Organización del Procesador
; 2016
; Inegrantes: Ameri Pablo, Etcheverry Pablo, Sanchez Diego
; PROGRAMA: Manejo de números intervalares que se pasan como parámetros
;           desde un programa en C

%include "asm_io.inc"
segment .data
	
   
segment .bss
    
segment .text
	global asm_main
	global sum_intervalo,  res_intervalo, mul_intervalo
	global inf_intervalo,  sup_intervalo
asm_main: 

;    FUNCION SUMA DE INTERVALOS
; recibe dos numeros intervalares
; X e Y con el formato XXXXxxxxh YYYYyyyyh 
; 16 bites para el limite superior 
; y 16 bites para el inferior  
; y devuelve un numero intervalar
; como resultado con el mismo formato
; en el caso que alguna de las sumas
; se salgan de representacion
; devolvera un [1,0] marcando el error

sum_intervalo:
	enter 0,0               
	mov ebx, [ebp+16]   		;segundo intervalo en ebx
	push ebx
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
	
	mov ebx , eax
	mov eax, [ebp+12]			; primer intervalo en eax
	push eax
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
    add ax , bx 				; ax = ax + bx :lim_inf z = lim_inf x + lim inf y  
    JO ofsuma    				; control de OF en caso de que la suma salga de representacion         
    ror eax , 16 				; reemplazo lim sup por resultado rotando 
    ror ebx , 16				; reemplazo lim sup por lim inf rotando
    add ax , bx 				; ax = ax + bx :lim_sup z = lim_sup x + lim sup y
    JO ofsuma 					; control de OF en caso de que la suma salga de representacion
    ror eax , 16				; roto nuevamente para devolver los limites a su pocicion
    jmp sumaok					; evito la carga de resultado erroneo con un salto 
ofsuma:
    mov eax , 00000001h			; en caso de error devuelve [1,0]
    sumaok:
    mov ebx , [ebp+8] 		    ; en ebp+8 esta la direccion del resultado
    mov [ebx] , eax             ; devuelvo resultado a la direccion 
leave
ret



;   FUNCION RESTA DE INTERVALOS
; recibe dos numeros intervalares
; X e Y con el formato XXXXxxxxh YYYYyyyyh 
; 16 bites para el limite superior 
; y 16 bites para el inferior  
; y devuelve un numero intervalar
; como resultado con el mismo formato
; en el caso que alguna de las restas
; se salgan de representacion
; devolvera un [1,0] marcando el error



 
res_intervalo:
	enter 0,0
	mov ebx, [ebp+16]   		;segundo intervalo en ebx
	push ebx
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
	mov ebx , eax
	mov eax, [ebp+12]			;primer intervalo en eax
	push eax
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4

	sub ax , bx					; ax = ax - bx :lim_inf z = lim_inf x - lim inf y  
    Jo ofresta					; control de OF en caso de que la resta salga de representacion 
    ror eax , 16				; reemplazo lim sup por resultado rotando
    ror ebx , 16				; reemplazo lim sup por lim inf rotando
    sub ax , bx					; ax = ax - bx :lim_sup z = lim_sup x - lim sup y 
    Jo ofresta					; control de OF en caso de que la resta salga de representacion 
    mov ebx, eax				; copio el resultado en ebx	
    ror eax , 16				; paso el lim inf a la parte baja del reg
    movsx eax, ax				; extiendo el signo a la parte alta 
    movsx ebx, bx 				; extiendo el signo a la parte alta
    cmp eax, ebx				; comparo lim inf y lim sup	
    jl esta_bien				; si estan ordenados no hace nada y salta
    ror eax , 16				; devuelvo el lim inf a su pocicion	 
    mov ax, bx					; muevo el lim sup en bx a ax
    jmp next					;
esta_bien:						;
	ror ebx, 16					; subo bx a la parte alta del registro    
	mov bx, ax					; muevo en bx el lim que esta el ax
	mov eax, ebx					; muevo el resultado a eax
next:
	jmp restaok	
ofresta:	
	mov eax, 00000001h 			; en caso de error devuelve [1,0]
restaok:
	mov ebx , [ebp+8]			; en ebp+8 esta la direccion del resultado
	mov [ebx] , eax				; devuelvo resultado a la direccion 
leave
ret



;   FUNCION MULTIPLICACION DE INTERVALOS
; recibe dos numeros intervalares
; X e Y con el formato XXXXxxxxh YYYYyyyyh 
; 16 bites para el limite superior 
; y 16 bites para el inferior  
; y devuelve un numero intervalar
; como resultado con el mismo formato
; en el caso que algun producto
; se salga de representacion
; devolvera un [1,0] marcando el error



mul_intervalo:
enter 16,0
mov ebx, [ebp+16]   		; segundo intervalo en ebx
	push ebx
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
	mov ebx , eax
	mov eax, [ebp+12]			; primer intervalo en eax
	push eax
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
	mov [ebp-4] , eax 			;guardo el primer intervalo en la pila
    mov [ebp-8] , ebx			;guardo el segundo intervalo en la pila
    mov eax, 0 					                 
    mov ebx, 0 						
    mov ecx, 0					;inicializo en 0 los registros que voy a utilizar
    mov ax, [ebp-4]             ;cargo en ax el lim inf de X
    mov bx, [ebp-8] 			;cargo en bx el lim inf de Y  
    movsx eax, ax				;extiendo el signo 
    movsx ebx, bx
    imul eax, ebx				;multiplico con signo  
    push eax
    call control          		;esta funcion controla si el resultado se sale de representacion
    add esp, 4
    cmp ecx, 1					;si salio de representacion, ecx es 1 y finalizo con error
    jz f_repres					; salto por fuera de representacion
    mov [ebp-12], eax   		;guardo el primer resultado como resultado menor 
    mov [ebp-16], eax   		;guardo el primer resultado como resultado mayor 
    mov eax , 0
    mov ax, [ebp-4]				;cargo en ax el lim inf de X   
    mov bx, [ebp-6]				;cargo en bx el lim sup de Y
    movsx eax, ax				;y repito la operacion anterior
    movsx ebx, bx
    imul eax, ebx
    push eax
    call control				
    add esp, 4					
    cmp ecx, 1										
    jz f_repres					
    push eax 					;resultado a la pila 
    push dword [ebp-16]     	;max a la pila
    push dword [ebp-12] 		;min a la pila
   call max_min					;ahora para cargar el resultado utilizo la funcion max_min 
    add esp, 12
    mov [ebp-12] , ebx			;guardo el nueno min 
    mov [ebp-16] , eax			;guardo el nuevo max 
    mov eax, 0
    mov ebx, 0
    mov ax, [ebp-2]				;cargo en ax el lim sup de X 
    mov bx, [ebp-8]				;cargo en bx el lim inf de Y
    movsx eax, ax				;y repito la operacion anterior
    movsx ebx, bx
    imul eax, ebx
    push eax
    call control
    add esp, 4
    cmp ecx, 1
    jz f_repres
   push eax
    push dword [ebp-16]
    push dword [ebp-12]
   call max_min
    add esp, 8
    mov [ebp-12] , ebx			
    mov [ebp-16] , eax
    mov eax, 0
    mov ebx, 0
    mov ax, [ebp-2]				;cargo en ax el lim sup de X 
    mov bx, [ebp-6]				;cargo en bx el lim sup de Y 
    movsx eax, ax				;y repito la operacion anterior
    movsx ebx, bx
    imul eax, ebx
    push eax
    call control
    add esp, 4
    cmp ecx, 1
    jz f_repres
    push eax
    push dword [ebp-16]
    push dword [ebp-12]
    call max_min
    add esp, 8
    ror eax, 16					;el ultimo mayor a la parte alta
    mov ax, bx                  ;el ultimo menor a la parte baja
    jmp mul_ok					;salto porque la multiplicacion finalizo sin errores de representacion  
    f_repres:					
    mov eax, 00000001h			;en caso de que ecx fuera 1 en cualquiera de las anteriores cuentas, me trae aqui
mul_ok:
    mov ebx , [ebp+8]			;en ebp+8 esta la direccion del resultado
    mov [ebx] , eax				;devuelvo resultado a la direccion 
     
leave
ret



;   FUNCION INFIMO ENTRE DOS INTERVALOS
; recibe dos numeros intervalares
; X e Y con el formato XXXXxxxxh YYYYyyyyh 
; 16 bites para el limite superior 
; y 16 bites para el inferior  
; y devuelve un numero intervalar
; como resultado con el mismo formato
; en el caso donde el resultado sea vacio
; devolvera un [1,0] marcando intervalo vacio


inf_intervalo:
enter 8,0
	mov ebx, [ebp+16]   		; segundo intervalo en ebx
	push ebx
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
	
	mov ebx , eax
	mov eax, [ebp+12]			; primer intervalo en eax
	push eax
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
    push eax
    push ebx
    call ordena				;los ordeno para poder luego determinar si es o no vacio
    add esp , 8
    mov [ebp-4] , eax  			;guardo el intervalo en ebp-4
    mov [ebp-8] , ebx 			;guardo el intervalo en ebp_8
    mov eax, 0   	            ;inicializo eax con valor 0		
    mov ebx, 0					;inicializo ebx con valor 
    mov ax, [ebp - 2]			;guardo en 
    mov bx, [ebp - 8]           ;
    cmp ax, bx 					;comparo el limite sup del intervalo que tiene el menor de los limites inferiores con el lim sup del del otro  
								;intervalo, en el caso de que sea menor es que no existe un intervalo infimo y es vacio.
    jl vacio      				;salta en caso de que sea vacio
    mov ax, [ebp-4]				;muevo en ax el lim inf del primer intervalo
    mov bx, [ebp-8] 			;muevo en bx el lim inf del segundo intervalo
    cmp ax, bx 					; comparo ambos limites
    Jg ax_inf_mayor				; salto si en ax esta el mayor
    mov ax , bx					; si no salto, es que en bx esta el mayor, entonces lo muevo a ax
ax_inf_mayor:				
    mov [ebp-4] , ax			; guardo el lim inf del resultado
    mov ax, [ebp-2]				; muevo en ax el lim sup del primer intervalo
    mov bx, [ebp-6] 			; muevo en ax el lim suo del segundo intervalo
    cmp ax, bx					; comparo ambos limites
    
    Jl ax_inf_menor				; salto si en ax esta el menor
    mov ax , bx					; si no salto, es que en bx esta el menor, entonces lo muevo a ax
ax_inf_menor:
    mov [ebp-2] , ax			;guardo en ebp-2 el lim sup del resultado
    mov eax , [ebp-4] 			;muevo el resultado en eax
    jmp fin
vacio:
    mov eax , 00000001h			;en caso de vacio devuelve [1,0]
    fin:
    mov ebx , [ebp+8]			;en ebp+8 esta la direccion del resultado
    mov [ebx] , eax				;devuelvo resultado a la direccion 
leave
ret



;   FUNCION SUPREMO ENTRE DOS INTERVALOS
; recibe dos numeros intervalares
; X e Y con el formato XXXXxxxxh YYYYyyyyh 
; 16 bites para el limite superior 
; y 16 bites para el inferior  
; y devuelve un numero intervalar
; como resultado con el mismo formato
; en el caso donde este resultado incluya 
; un intervalo que no pertenezca al
; supremo, ejm [1,2][4,5] el [3,3] no corresponde 
; devolvera un [1,0] marcando intervalo vacio



sup_intervalo:
enter 16,0
	mov ebx, [ebp+16]   		; segundo intervalo en ebx
	push ebx
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
	
	mov ebx , eax
	mov eax, [ebp+12]			; primer intervalo en eax
	push eax
	call ordena_limites			;funcion que ordena los limites si estan invertidos [lim sup, lim inf]
	add esp,4
    push eax					
    push ebx
    call ordena					;los ordeno para poder luego determinar si es o no un intervalo valido
    add esp , 8					
    mov [ebp-4] , eax			;guardo el intervalo en ebp-4
    mov [ebp-8] , ebx 			;guardo el intervalo en ebp-8
    mov eax, 0					
    mov ebx, 0
    mov ax, [ebp - 2]			;guardo en ax el lim sup del primer intervalo
    mov bx, [ebp - 8]			;guardo en bx el lim inf del segundo intervalo
    push ebx
    sub bx , 1					; resto 1 al lim inf del segundo intervalo para luego compararlo 
								;con el lim sup del primero, para que un intervalo no sea valido tiene que 
								;haber al menos un numero entre los dos intervalos que no corresponda a ninguno de ellos
    cmp ax, bx 					; comparo ax y bx
   jl invalido             		; si bx es mayor salta por intervalo invalido
    pop ebx						; restauro bx luego de la comparacion
    mov eax, 0					
    mov ebx, 0
    
    mov ax, [ebp-2]  				;muevo a ax el lim sup del primer intervalo
    mov bx, [ebp-6] 				;muevo a bx el lim sup del segundo intervalo
    cmp ax, bx   					;comparo ambos limites para obtener el mayor
    
    Jg ax_sup_mayor           		;salta si ax es mayor que bx
     mov ax , bx					;si no salto, el mayor es bx, entonces lo muevo a ax
    ax_sup_mayor: 					
    
    ror eax, 16						;roto eax para correr el lim sup del resultado en la parte alta del registro
    mov ax, [ebp-4]					;muevo el lim inf del resultado a ax
     jmp fin1 
    invalido:
    mov eax , 00000001h				;en caso de resultado invalido, muestro el intervalo [1,0]
    fin1:
    mov ebx , [ebp+8]				;en ebp+8 esta la direccion del resultado
    mov [ebx] , eax					;devuelvo resultado a la direccion
leave
ret
    
   


;Funcion usada en la multiplicacion para ir guardando el min y max
;en esta funcion guardo en eax y en ebx
;el resultado obtenido en la multiplicacion
;luego comparo con el maximo guardado y el 
;minimo guardado y en ambos casos lo reemplazo
;en caso de ser el nuevo mayor o el nuevo menor
;en eax y ebx retorno los dos resultados
max_min:							
  enter 0,0							
	mov eax, [ebp+16]				;guardo en eax el resultado de la multiplicacion
	mov ebx, [ebp+16]				;guardo en ebx el resultado de la multiplicacion
	movsx eax , ax					;extieno el signo al resto del registro ex a eax
	cmp eax, [ebp+12]				;comparo eax con el antiguo menor
	Jg eaxmayor 					;salta si eax es mayor 
	mov eax, [ebp+12]				;guardo el nuevo mayor en eax (se conserva el anterior)
	eaxmayor:						
	movsx ebx,bx					;wxtiendo el signo al resto del registro bx a ebx
	cmp ebx, [ebp+8]				;comparo ebx con el antiguo menor
	Jl ebxmenor 					;salta si ebx es menor en ebx
	mov ebx, [ebp+8]				;guardo el nuevo menor en ebx (se conserva el anterior)
	ebxmenor:
  leave
  ret
  

 


;funcion utilizada para ordenar los intervalos
;es usada para poder determinar en el infimo y el supremo
;si el resultado es vacio en el infimo o invalido en el supremo

ordena:								
   enter 4 , 0 						
   mov ebx, [ebp+8] 				;guardo en ebx el primer intervalo					
   mov eax, [ebp+12]				;guardo en eax el segundo intervalo
   cmp ax , bx						;comparo ax con bx
  jl ordenado						;si estan ordenados salta
   mov [ebp-4] , eax				;guardo en el espacio reservado eax	
   mov eax , ebx					;reemplazo eax por ebx
   mov ebx , [ebp-4]				;guardo en ebx ebp-4
  ordenado:
   leave
  ret 	
   




;funcion que controla si se sale de representacion fuera de los 16 bits
;shifteo con signo a la derecha los 15 lugares
;que puede abarcar como maximo la representacion
;de la multiplicacion, los proximos 17 bits pertenecen al
;signo, luego comparo con -1 y con 0, si es distinto a cualquiera
;de esos valores, es que se paso de representacion
;y en ecx devuelvo un 1 para informar el error

control:
enter 0,0
	mov eax, [ebp+8]				;muevo a eax el resultado
	push eax						;guardo eax en la pila
	sar eax, 15						;shifteo con signo 15 a derecha
	cmp eax , 0						;comparo eax con 0
	jz cero							;salto a cero: si zf es 1
	cmp eax , -1					;comparo eax con -1	
	jz cero							;salto a cero: si zf es 1
	mov ecx , 1						;guardo un 1 en ecx
 cero:
	pop eax							;restauro eax
	leave 
ret



;funcion que ordena los limites en caso de estar invertidos  

ordena_limites:
	enter 4,0
	mov eax, [ebp+8]				;muevo a eax el intervalo 
	mov [ebp-4], eax				;guardo en ebp-4 el intervalo
	cmp ax, [ebp-2]					;comparo lim inf y lim sup
	jl lim_ordenado     			;si ax es menor que bx, estan bien ordenados
	ror eax,16						;si no salto en la linea anterior, significa que estaban invertidos y debo cambiar sus posiciones
	mov ax, [ebp-2]					;o sea que roto eax para pasar el limite a la parte superior y luego guardo en ax el otro limite
lim_ordenado:
	leave
ret
   
