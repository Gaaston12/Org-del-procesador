;suma la cantidad de numeros ingresados

Start:	read		; read n -> acc
	    jmpn  Done  	; jump to Done if n < 0.
        load  one       ; 1 -> acc
	    add   sum  	; add sum to the acc
	    store sum 	; store the new sum
	    jump  Start	; go back & read in next number
Done:	load  sum 	; load the final sum
	    write 		; write the final sum
	    stop  		; stop

sum:	.data 2 0 ; 2-byte location where sum is stored
one:    .data 2 1 ;2-byte location for the constant one

