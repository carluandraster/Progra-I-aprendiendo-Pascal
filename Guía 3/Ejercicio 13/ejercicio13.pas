{Reescribir usando Repeat-Until:
Readln( Tipo, Precio); Tipo := Upcase(Tipo);
 {P=panadería, F=fiambrería, A=almacén}{
 While (Tipo<>’P’) and (Tipo<>’F’) and (Tipo<>’A’) do
 Begin
 Readln (Tipo); Tipo := Upcase(Tipo);
 End;}

 Program ejercicio13;

 var
    tipo:char;
    precio:real;

begin
    write('Ingrese precio');
    Readln(precio);
    repeat
        writeLn('Ingrese tipo: ');
        Readln(Tipo);
        Tipo := Upcase(Tipo);
    until (Tipo='P') or (Tipo='F') or (Tipo='A'); {Por ley de De Morgan}
end.

{Conclusion: para validar un dato ingresado por teclado, es mejor un ciclo Repeat-Until
porque de esta forma solo pongo en el codigo que lea Tipo de teclado una sola vez, a
diferencia de un ciclo while en el que tenés que preguntar 2 veces para entrar al ciclo}