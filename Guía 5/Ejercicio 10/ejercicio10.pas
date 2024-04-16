{Dado un arreglo A, generar dos arreglos paralelos B y C donde B contiene la suma de los
elementos de A que están entre dos negativos y C la cantidad que se sumó. Mostrar B y C. }

Program ejercicio10;

type
    TV1 = array[1..255] of byte;
    TV2 = array[1..255] of integer;

// Subprogramas

// Generar arreglo A
procedure leerArchivo(var A:TV2; var N:byte);
var
    i:byte;
    archivo:text;
begin
    // Inicializar variable
    i:=1;

    // Archivo de texto
    assign(archivo,'arreglo.txt');
    reset(archivo);

    // Almacenar en el arreglo A lo que hay en el archivo
    while not eof(archivo) do
    begin
        read(archivo,A[i]);
        i:=i+1;
    end;
end;

// Generar B
procedure acumulador(A:TV2; N:byte; var B:TV1; var M:byte);
var
    i,suma,contaNegativos:byte;
begin
    // Inicializar variables
    contaNegativos:=0;

    // Recorrer arreglo A
    for i:=1 to N do
    begin
        if A[i]<0 then
        begin
            if contaNegativos>0 then B[contaNegativos]:=suma;
            // Actualizar variables
            contaNegativos:=contaNegativos+1;
            suma:=0;
        end
        else
            // Acumular
            suma:=suma+A[i];
    end;

    M:=contaNegativos-1;
end;

// Generar C
procedure contador(A:TV2; N:byte; var C:TV1);
var
    i,conta,contaNegativos:byte;
begin
    // Inicializar variables
    contaNegativos:=0;

    // Recorrer arreglo A
    for i:=1 to N do
    begin
        if A[i]<0 then
        begin
            if contaNegativos>0 then C[contaNegativos]:=conta;
            // Actualizar variables
            contaNegativos:=contaNegativos+1;
            conta:=0;
        end
        else
            // Contar
            conta:=conta+1;
    end;
end;

// Mostrar arreglo
procedure escribirArray(A:TV1;N:byte);
var
    i:byte;
begin
    for i:=1 to N do
        write(A[i],' ');
end;

// Programa principal

var
    A:TV1;
    B,C:TV2;
    N,M:byte;

begin
    leerArchivo(A,N);
    acumulador(A,N,B,M);
    contador(A,N,B);

    // Mostrar resultados
    write('Vector B: ');
    escribirArray(B,M);
    writeLn();
    write('Vector C: ');
    escribirArray(C,M);
end.