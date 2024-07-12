Program ejercicio3;

function confuso(a,b:integer):integer;
begin
    if (b = 0) then
        confuso := 0
    else
        if (b mod 2 = 0) then
            confuso := confuso(a+a, b div 2)
        else
            confuso := confuso(a+a, b div 2) + a;
end;

var
    a,b: integer;

begin
    writeLn('Ingrese dos numeros: ');
    readLn(a);
    readLn(b);

    writeLn('Confuso = ',confuso(a,b));
end.

{La función confuso devuelve el producto entre a y |b|.
La forma en que lo hace es más confusa que el nombre porque tiene una forma muy particular de
descomponer el producto. Por ejemplo, si los parámetros son 2 y 3 el resultado es 6 pero la suma
que hace es la siguiente: 4+2=6. Ni suma 3 veces 2 ni suma 2 veces 3. Otro ejemplo es 5 y 10 que
dan 50. A 50 lo descompone como 40+10. De la misma forma, 34=32+2
Ver demostración formal en el cuaderno.}