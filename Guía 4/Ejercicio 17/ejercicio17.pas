{Mediante una función booleana informar si un número es primo. }

Program ejercicio17;

function esPrimo(n:word):boolean;
var
    i:word;
    primo:boolean;
begin
    primo:=true;
    for i:=2 to trunc(sqrt(n)) do
      if n mod i = 0 then
        begin
          primo:=false;
          break;
        end;
    esPrimo:=primo;
end;

var
    n:word;

begin
    // Ingresar n
    write('Ingrese un numero: ');
    read(n);

    if esPrimo(n) then
        writeLn(n,' es primo.')
    else
        writeLn(n,' no es primo.');
end.