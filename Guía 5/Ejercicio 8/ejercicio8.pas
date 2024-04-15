{Dado un arreglo V de N elementos ordenados en forma ascendente con componentes repetidas,
generar W con la frecuencia de los elementos de V. Mostrar W }

Program ejercicio8;

type
    TV= array[1..255] of byte;

// Subprogramas

procedure ingresarV(var N:byte; var V:TV);
var
    i:byte;

begin
    writeLn('Cuantos numeros va a ingresar?');
    readLn(N);

    for i:=1 to N do
    begin
        repeat
            writeLn('Ingrese numero ',i);
            readLn(V[i]);
        until V[i]>=V[i-1];
    end;
end;

procedure limpiar(var A:TV);
var
    i:byte;
begin
    for i:=1 to 255 do
        A[i]:=0;
end;

procedure frecuenciar(N:byte;V:TV; var W:TV;var j:byte);
var
    i:byte;
begin
    // Inicializar variables
    i:=1;
    j:=0;
    limpiar(W);

    // Contar repeticiones
    while i<=N do
    begin
        j:=j+1;
        repeat
            W[j]:=W[j]+1;
            i:=i+1;
        until V[i]<>V[i-1];
    end;
end;

procedure mostrarArreglo(A:TV;N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        writeLn(A[i]);
end;

// Programa principal

var
    V,W:TV;
    N,j:byte;

begin
    ingresarV(N,V);
    frecuenciar(N,V,W,j);

    writeLn('El vector W es: ');
    mostrarArreglo(W,j);
end.