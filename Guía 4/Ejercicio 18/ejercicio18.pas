{Desarrollar la Función MCD que devuelve el máximo común divisor entre dos números}

Program ejercicio18;

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

var
    maximoComunDivisor:word;
    x,y:integer;

begin
    // Ingresar numeros
    writeLn('Ingrese dos numeros enteros: ');
    readLn(x,y);

    // Sacar mcd
    maximoComunDivisor:=mcd(x,y);

    // Imprimir mcd
    writeLn('mcd(' , x , ',' , y , ') = ', maximoComunDivisor);
end.