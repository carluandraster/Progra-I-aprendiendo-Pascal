{Mediante una función booleana determinar si un número es capicúa. }

Program ejercicio16;

// Funciones

function invertirString(x:string):string;
var
    i:byte;
    y:string;
begin
    y:='';
    for i:=length(x) downto 1 do
        y:=y+x[i];
    invertirString:=y;
end;

function capicua(x:word):boolean;
var
    xStr,yStr:string;
begin
    Str(x,xStr);
    yStr:=invertirString(xStr);
    capicua:=xStr=yStr;
end;

// Programa principal

var
    n:word;

begin
    // Ingreso de dato por teclado
    writeLn('Ingrese un numero: ');
    readLn(n);

    // Imprimir resultado
    if capicua(n) then
        writeLn(n,' es capicua')
    else
        writeLn(n,' no es capicua');
end.