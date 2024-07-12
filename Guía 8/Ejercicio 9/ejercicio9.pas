{Implementar un procedimiento o función recursiva que determine si los dígitos de un número
natural están dispuestos de forma creciente}


program ejercicio9;

function creciente (x: word): boolean;
var
    N: byte;
begin
    N:=trunc(ln(x)/ln(10))+1; {Cantidad de digitos}

    if N>1 then
        if x mod 10 >= (x mod 100) div 10 then
            creciente:=creciente(trunc(x/10))
        else
            creciente:=false
    else
        creciente:=true;
end;

// Programa principal

var
    x: word;

begin
    repeat
        writeLn('Ingrese un numero natural: ');
        readLn(x);
    until x>0;
    
    if creciente(x) then
        writeLn('Los digitos estan dispuestos en forma creciente.')
    else
        writeLn('Los digitos NO estan dispuestos en forma creciente.');
end.