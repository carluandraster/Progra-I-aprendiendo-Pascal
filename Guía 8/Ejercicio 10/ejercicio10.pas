{Dado dos arreglos de enteros A y B ordenados ascendentemente, realizar un algoritmo
recursivo que mezcle ambos arreglos en otro C manteniendo el orden. Cada arreglo no tiene
valores repetidos. Si un valor aparece en ambos arreglos, debe pasar a C uno solo.}

Program ejercicio10;

const
    tope = 100;

type
    TV = array [1..tope] of byte;


// Subprogramas

procedure leerArchivo (var A,B: TV; var N,M: byte);
var
    archivo: text;
begin
    // Inicializar variables
    N:=0;
    M:=0;

    // Abrir archivo
    assign(archivo,'arreglos.txt');
    reset(archivo);

    // Leer archivo
    while not eoln(archivo) do
    begin
        N:=N+1;
        read(archivo,A[N]);
    end;
    readLn(archivo);
    while not eoln (archivo) do
    begin
        M:=M+1;
        read(archivo,B[M]);
    end;

    // Cerrar archivo
    close(archivo);
end;

procedure mezclar (var C: TV; var K: byte;A,B: TV; N,M: byte);
begin
    if (N>0) and (M>0) then
        if B[M]>A[N] then
        begin
            C[M+N+K-1]:=B[M];
            mezclar(C,K,A,B,N,M-1);
        end
        else
        begin
            C[M+N+K-1]:=A[N];
            if B[M]<A[N] then
                mezclar(C,K,A,B,N-1,M)
            else
                begin
                    K:=K+1;
                    mezclar(C,K,A,B,N-1,M-1);
                end;
        end
    else
        if (N=0) and (M>0) then
        begin
            C[M+K-1]:=B[M];
            mezclar(C,K,A,B,N,M-1);
        end
        else
            if (M=0) and (N>0) then
            begin
                C[N+K-1]:=A[N];
                mezclar(C,K,A,B,N-1,M);
            end;
end;

procedure imprimirArreglo (C: TV; i,K: byte);
begin
    if i>K then
        imprimirArreglo(C,i-1,K);
    write(C[i],' ');
end;


// Programa principal

var
    A,B,C: TV;
    N,M,K: byte;
begin
    leerArchivo(A,B,N,M);

    K:=1;
    mezclar(C,K,A,B,N,M);

    writeLn('Arreglo mezcla: ');
    imprimirArreglo(C,N+M,K);
end.