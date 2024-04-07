{Hacer un programa que dada una fracción (numerador y denominador) la simplifique usando la
función MCD}

Program ejercicio19;

// Funciones y procedimientos

function mcd(n1,n2:integer):word;
var
    i:integer;
begin
    n1:=abs(n1);
    n2:=abs(n2);
    for i:=n1 downto 1 do
      if (n1 mod i = 0) and (n2 mod i = 0) then
      begin
        mcd:=i;
        break;  
      end;      
end;

procedure simplificar(var numerador,denominador:integer);
    var
        maximoComunDivisor:word;
begin
    maximoComunDivisor:=mcd(numerador,denominador);
    while maximoComunDivisor<>1 do
        begin
          numerador:=round(numerador/maximoComunDivisor);
          denominador:=round(denominador/maximoComunDivisor);
          maximoComunDivisor:=mcd(numerador,denominador);
        end;
end;

// Programa principal

var
    numerador,denominador:integer;

begin
    // Ingresar datos por teclado

    writeLn('Ingrese numerador: ');
    readLn(numerador);

    repeat
        writeLn('Ingrese denominador: ');
        readLn(denominador);
    until denominador<>0;

    // Simplificar fracción
    simplificar(numerador,denominador);

    // Imprimir fracción simplificada
    writeLn('La fraccion simplificada es ',numerador,'/',denominador);
end.