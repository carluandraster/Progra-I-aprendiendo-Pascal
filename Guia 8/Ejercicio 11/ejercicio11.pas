{Desarrollar un procedimiento recursivo para imprimir una media pirámide de dígitos}

Program ejercicio11;

{Nota: Utilizar un procedimiento recursivo para generar cada fila de la media pirámide}
procedure fila (x: byte);
begin
    write(x,' ');
    if x>1 then
        fila(x-1);
end;

procedure mediaPiramide (x: byte);
begin
    if x>1 then
        mediaPiramide(x-1);
    fila(x);
    writeLn;
end;

// Programa principal
var
    x: byte;
begin
    repeat
        writeLn('Ingrese un numero natural: ');
        read(x);
    until x>0;

    mediaPiramide(x);
end.