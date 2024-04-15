{Realizar la suma de dos números positivos muy grandes (de 10 cifras, por ejemplo). Implementar el
programa principal que lea ambos números, invoque el subprograma que resuelve la suma y muestre el
resultado. }

Program ejercicio7;

type
    TV= array[1..255] of byte;

// Subprogramas

procedure limpiar(var A:TV);
var
    i:byte;
begin
    for i:=1 to 255 do
        A[i]:=0;
end;

procedure de_str_a_arr(x:string; var A:TV; var N:byte);
var
    i:byte;
begin
    limpiar(A);
    N:=length(x);
    for i:=1 to N do
        val(x[i],A[255-N+i]);
end;

function maximo(N,M:byte):byte;
begin
    if N>M then
        maximo:=N
    else
        maximo:=M;
end;

procedure suma(A,B:TV; var C:TV; N,M:byte);
var
    i,resto,limInf:byte;
begin
    // Inicializar variables
    resto:=0;
    limInf:=255-maximo(N,M);
    limpiar(C);

    for i:=255 downto limInf do
    begin
        C[i]:=A[i]+B[i]+resto;
        if C[i]>=10 then
        begin
            resto:=C[i] div 10;
            C[i]:=C[i] mod 10;
        end
        else
            resto:=0;
    end;
end;

procedure mostrarArreglo(A:TV);
var
    i:byte;
    mostrar:boolean;
begin
    mostrar:=false;
    for i:=1 to 255 do
    begin
        if A[i]<>0 then
            mostrar:=true;
        if mostrar then
            write(A[i]);
    end;
end;

// Programa principal

var
    num1,num2:string;
    A,B,C:TV;
    N,M:byte;

begin
    // Ingresar numeros
    writeLn('Ingrese un numero: ');
    readLn(num1);

    writeLn('Ingrese el otro numero: ');
    readLn(num2);

    // Pasar ambos strings a arreglo
    de_str_a_arr(num1, A, N);
    de_str_a_arr(num2,B,M);

    // Sumar numeros
    suma(A,B,C,N,M);

    // Mostrar suma
    writeLn('Suma total: ');
    mostrarArreglo(C);
end.