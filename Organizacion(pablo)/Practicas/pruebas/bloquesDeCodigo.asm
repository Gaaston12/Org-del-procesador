
;BLOQUE PARA EL SI..ENTONCES..SINO

	;code to set FLAGS
	jxx		else_block		;selecciona xx tal que se salta si la condición es falsa

	;código par ael bloque entonces
	jmp endif

else_block:
	;código para el bloque esle
endif:
_____________________________________________________________________________________________________
;BLOQUE PARA EL SI..ENTONCES
	Si no hay else, entonces el salto al else_block puede ser reemplazado por un salto a endif

	:Código para establecer FLAGS
	jxx endif				;selecciona xx tal que se salta si la condición es falsa
	;código para el bloque entonces
endif:

_____________________________________________________________________________________________________
;BLOQUE PARA EL WHILE
	while(condición){
		cuerpo del bucle;
	}

while:
	;Código que fija FLAGS basado en la condición
	jxx	endwhile	;selecciona xx tal que salte si es falso
	;Cuerpo del bucle
	jmp while
endwhile:
_____________________________________________________________________________________________________
;BLOQUE PARA EL DO WHILE
	do{
		cuerpo del bucle;
	}while(condición)

do:
	;Cuerpo del bucle
	;código para fijar FLAGS basado en la condición
	jxx do 		;seleccionar xx tal que salte si es verdadero
