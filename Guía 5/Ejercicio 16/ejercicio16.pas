{Se pide compactar un arreglo, como en el ejercicio 4, pero sin usar estructura auxiliar}

Program ejercicio16;

type
    TV = array [1..255] of byte;

// Subprogramas


Procedure ingresar(var A:TV;var N:byte);
var
    i:byte;
    num:integer;
begin
    // Inicializar variables
    i:=0;

    // Ingresar por teclado el arreglo A
    repeat
        i:=i+1;
        repeat
            writeLn('Ingrese un numero (-1 para cortar)');
            readLn(num);
        until (num>=-1) and (num<256);
        
        if num>=0 then
            A[i]:=num;
    until num<0;

    N:=i-1;
end;

Procedure compactar(var A:TV;var N:byte);
var
    i,j:byte;
begin
    for i:=1 to N do
        if A[i]=0 then
        begin
            if i<N then
                repeat
                    for j:=i to N-1 do
                        A[j]:=A[j+1];
                    N:=N-1;
                until A[i]<>0
            else
            begin
                N:=N-1;
                break;
            end;
        end;    
end;

procedure imprimirArr(A: TV; N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        write(A[i],' ');
end;

// Programa principal

var
    A:TV;
    n:byte;
begin
    ingresar(A,n);
    compactar(A,n);
    write('El arreglo compactado es: ');
    imprimirArr(A,n);
end.