program IntgerTest;
{$BITPACKING ON}

const cantBits = 32;
type TByteBits = bitpacked array[0..cantBits-1] of Boolean;
type TPByteBits = ^TByteBits;
     
var a:Integer;
    pc:TPByteBits; 

procedure PrintBits(p:TPByteBits);
var i:integer;
begin
	for i:=1 to cantBits do begin
	  if p^[i-1] then write('1')
	  else write('0');
	end;
end;

begin
a:=576;
pc:=@a;
writeln();
PrintBits(pc);

end.