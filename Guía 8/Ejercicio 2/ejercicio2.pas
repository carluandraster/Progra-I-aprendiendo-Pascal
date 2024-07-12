Program ejercicio2;

function f(i: byte): byte;
begin
    if i=0 then
        f:=1
    else
        if odd(i) then
            f:=f(i-1)
        else
            f:=1+f(i-1);
end;

var
    i: byte;

begin
    write('Ingrese un nummero: ');
    read(i);

    writeLn('Entre 0 y ',i,' hay ',f(i),' numeros pares.');
end.