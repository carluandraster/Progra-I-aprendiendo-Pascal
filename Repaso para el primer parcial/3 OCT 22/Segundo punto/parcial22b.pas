Program punto2;

// Funciones

function esSuave(x:word):boolean;
var
    xStr:string;
    i,num1,num2:byte;
    aux:boolean;
begin
    str(x,xStr);
    aux:=true; {El numero es suave hasta que se demuestre lo contrario}
    val(xStr[1],num1);
    for i:=2 to length(xStr) do
    begin
        val(xStr[i],num2);
        if abs(num1-num2)>1 then
        begin
            aux:=false;
            break;
        end;
        num1:=num2;
    end;
    esSuave:=aux;
end;

function esPrimo(n:word):boolean;
var
    i:word;
    primo:boolean;
begin
    primo:=true; {El numero es primo hasta que se demuestre lo contrario}
    for i:=2 to trunc(sqrt(n)) do
      if n mod i = 0 then
        begin
          primo:=false;
          break;
        end;
    esPrimo:=primo;
end;

// Programa principal

var
    A,B,i,contador:word;

begin
    // Inicializar variables
    contador:=0;

    // Ingresar datos por teclado
    repeat
        writeLn('Ingrese un numero: ');
        readLn(A);
    until A>=10;

    repeat
        writeLn('Ingrese un numero mas grande: ');
        readLn(B);
    until B>A;

    // Contar cuántos números son suaves y compuestos (no primos) en el intervalo [A,B]
    for i:=A to B do
    begin
        if esSuave(i) and not esPrimo(i) then
            contador:=contador+1;
    end;

    // Imprimir resultado
    writeLn('Hay ',contador,' numeros con las caracteristicas buscadas entre ',A,' y ',B);
end.