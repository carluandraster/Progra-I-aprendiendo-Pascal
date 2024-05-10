{Escribir un subprograma recursivo que retorne una cadena de caracteres recibida como parametro
con su contenido invertido.
Ejemplo: ‘lamina’ -> ‘animal’ }


Program ejercicio4;

function invertir (x: string; N: byte): string;
begin
    if N>1 then
        invertir:=x[N]+invertir(x,N-1)
    else
        invertir:=x[N];
end;


var
    x: string;
    N: byte;

begin
    // Ingresar datos por teclado
    writeLn('Ingrese cadena de caracteres: ');
    read(x);
    N:=length(x);
    writeLn(invertir(x,N));
end.