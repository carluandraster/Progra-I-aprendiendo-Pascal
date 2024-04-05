{Dado un archivo que contiene en cada línea 4 números (N1, D1, N2, D2) numerador y
denominador de dos fracciones. Se pide leer los pares de fracciones y por cada uno de
ellos informe:
a) La suma como fracción.
b) El producto como fracción. }

Program ejercicio9;

// Multiplo comun menor
function mcm(n1,n2:integer):integer;
var
    i,j:byte;
    num1,num2:word;
begin
  i:=1;
  j:=1;
  repeat
    num1:=i*n1;
    repeat
      num2:=j*n2;
      j:=j+1;
    until num2>=num1;
    i:=i+1;
    j:=1;
  until num1=num2;
  mcm:=num1;
end;

procedure suma(n1,d1,n2,d2:integer;var numerador,denominador:integer);
begin
    denominador:=mcm(d1,d2);
    numerador:=round(denominador/d1)*n1+round(denominador/d2)*n2;
end;

procedure producto(n1,d1,n2,d2:integer;var numerador,denominador:integer);
begin
    numerador:=n1*n2;
    denominador:=d1*d2;
end;

var
    n1,d1,n2,d2,num,den: integer;
    archivo:text;

begin
    // Archivo de texto
    assign(archivo,'numeros.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
        begin
          readLn(archivo,n1,d1,n2,d2);
          // Suma
          suma(n1,d1,n2,d2,num,den);
          writeLn(n1,'/',d1,'+',n2,'/',d2,' = ',num,'/',den);
          // Producto
          producto(n1,d1,n2,d2,num,den);
          writeLn(n1,'/',d1,'x',n2,'/',d2,' = ',num,'/',den);
        end;
end.