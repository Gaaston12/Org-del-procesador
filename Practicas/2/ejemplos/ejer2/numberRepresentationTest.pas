program numberRepresentationTest.pas;

{$BITPACKING ON}
Uses Math; 

const cantBits = 32;
type TByteBits = bitpacked array[0..cantBits-1] of Boolean;
type TPByteBits = ^TByteBits;

var a:Integer;
	b:single;
    p,q:TPByteBits; 


(* Imprime una secuencia de bits (arreglo compactado de booleanos) *)
procedure PrintBits(p:TPByteBits);
var i:integer;
begin
	for i:=cantBits-1 downto 0 do begin
		if p^[i] then write('1')
	  		 else write('0');
	end;
end;


begin (* Programa *)
	a:= 255;
	b:= 0.0000075;
	p:=@a;
	q:=@b;
	writeln('-------Int 16bits------'); 
	PrintBits(p);writeln('');
	writeln('-------Real 32bits------'); 
	PrintBits(q);writeln('');
	writeln('-----------------------');	
end.
