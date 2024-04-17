{Un médico tiene en un archivo de texto información sobre sus pacientes ordenado por su número
de historia clínica. En cada línea:
• Número Historia Clínica (entero positivo, orden ascendente)
• Apellido y Nombre del Paciente (cadena de 30)
Se desea obtener un listado de los pacientes con apellidos que comienzan entre ‘A’ y ‘F’
ordenados alfabéticamente. }

Program ejercicio17;

type
    TVnum = array [1..255] of byte;
    TVstr = array [1..255] of string[30];

// Subprogramas

procedure leerArchivo(var A:TVnum; var B:TVstr; var N:byte);
var
    archivo:text;
    espacio:char;
begin
    // Reconocer archivo de texto
    assign(archivo,'pacientes.txt');
    reset(archivo);

    // Inicializar variable
    N:=0;

    // Recorrer archivo
    while not eof(archivo) do
    begin
        N:=N+1;
        readLn(archivo,A[N],espacio,B[N]);
    end;

    // Cerrar archivo
    close(archivo);
end;

function busqueda(x:string;B:TVstr;N:byte):byte;
var
    i:byte;
begin
    i:=1;
    while (i<=N) and (B[i]<>x) do
        i:=i+1;
    if B[i]<>x then
        busqueda:=0
    else
        busqueda:=i;
end;

procedure mayuscula(var A:TVstr;N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        A[i]:=upcase(A[i]);
end;

function primero(A:TVstr;comienzo,N:byte):string;
var
    antes:string;
    i:byte;
begin
    antes:='aaa';
    for i:=comienzo to N do
        if A[i]<antes then
            antes:=A[i];
    primero:=antes;
end;

procedure ordenarAlfabeticamente(var A:TVstr;N:byte);
var
    i,j:byte;
    B:TVstr;
    aux:string;
begin
    j:=1;
    B:=A;
    mayuscula(B,N);
    while j<=N do
    begin
        i:=busqueda(primero(B,j,N),B,N);
        aux:=B[j];
        B[j]:=B[i];
        B[i]:=aux;
        aux:=A[j];
        A[j]:=A[i];
        A[i]:=aux;
        j:=j+1;
    end;
end;

procedure deAaF(A:TVstr;var B:TVstr;N:byte; var j:byte);
var
    i:byte;
begin
    j:=0;
    for i:=1 to N do
    begin
        if A[i][1] in ['A'..'F'] then
        begin
            j:=j+1;
            B[j]:=A[i];
        end;
    end;
    ordenarAlfabeticamente(B,j);
end;

procedure imprimirArr(A: TVstr; N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        writeLn(A[i]);
end;

// Programa principal

var
    A: TVnum;
    B,C: TVstr;
    N,M:byte;

begin
    leerArchivo(A,B,N);
    deAaF(B,C,N,M);
    writeLn('Los pacientes de apellidos entre A y F son: ');
    imprimirArr(C,M);
end.