{Escriba un programa que lea una frase (secuencia de caracteres separada por espacio, coma, 
punto) y mediante un menú de opciones calcule e informe:
a) El número de palabras que contiene.
b) La longitud de la palabra más larga.
c) De todas las palabras, la que aparece antes en el diccionario. Analizar las alternativas de
almacenar dicha palabra en un arreglo de caracteres o en un string.
d) la frecuencia de cada letra (mayúscula o minúscula) que aparece en la frase.
No es necesario almacenar toda la frase en un arreglo.}

Program ejercicio6;

type
    TVstr= array[1..255] of string;
    TVreal= array['A'..'Z'] of real;

// Subprogramas

procedure limpiar(var A:TVstr);
var
    i:byte;
begin
    for i:=1 to 255 do
        A[i]:='';
end;

procedure limpiaReal (var A:TVreal);
var
    i:char;
begin
    for i:='A' to 'Z' do
        A[i]:=0;
end;

procedure leerArchivo(var A:TVstr; var N:byte);
var
    archivo:text;
    caracter:char;
begin
    // Inicializar variables
    N:=1;
    limpiar(A);
    assign(archivo,'frase.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        read(archivo,caracter);
        while (caracter in ['a'..'z']) or (caracter in ['A'..'Z']) or (caracter in ['0'..'9']) do
        begin
            if caracter in ['a'..'z'] then
                caracter:=upcase(caracter);
            A[N]:=A[N]+caracter;
            read(archivo,caracter);
        end;
        if (caracter<>'.') and (A[N]<>'') then
            N:=N+1;
    end;
end;

// b) La longitud de la palabra más larga.
function maxLongitud(A:TVstr;N:byte):byte;
var
    longitud,i:byte;

begin
    // Inicializar variables
    longitud:=0;

    // Recorrer arreglo
    for i:=1 to N do
        if length(A[i])>longitud then
            longitud:=length(A[i]);
    
    // Devolver resultado
    maxLongitud:=longitud;
end;

// c) De todas las palabras, la que aparece antes en el diccionario
function primero(A:TVstr;N:byte):string;
var
    antes:string;
    i:byte;
begin
    antes:='aaa';
    for i:=1 to N do
        if A[i]<antes then
            antes:=A[i];
    primero:=antes;
end;

// d) la frecuencia de cada letra (mayúscula o minúscula) que aparece en la frase.
procedure contarLetras(A:TVstr; N:byte; var B:TVreal);
var
    i,j:byte;
begin
    limpiaReal(B);
    for i:=1 to N do
        for j:=1 to length(A[i]) do
            if not (A[i][j] in ['0'..'9']) then
                B[A[i][j]]:=B[A[i][j]]+1;
end;

procedure frecuencia(A:TVstr;N:byte; var B:TVreal);
var
    i:char;
begin
    contarLetras(A,N,B);
    for i:='A' to 'Z' do
        B[i]:=B[i]/N;
end;

procedure imprimirArreglo(A:TVreal);
var
    i:char;
begin
    for i:='A' to 'Z' do
        if A[i]<>0 then
            writeLn('La letra ',i,' ha aparecido con una frecuencia de ',A[i]:0:2,' veces por palabra');
end;

// Programa principal

var
    opcion,N:byte;
    A:TVstr;
    B:TVreal;

begin
    // Inicializar A
    leerArchivo(A,N);

    // Menu de opciones
    repeat
        writeLn('Seleccione una opcion: ');
        writeLn('1 - Ver cantidad de palabras');
        writeLn('2 - Ver longitud de la palabra mas larga');
        writeLn('3 - Ver primera palabra del diccionario');
        writeLn('4 - Ver frecuencia de cada letra');
        readLn(opcion);
    until (opcion=1) or (opcion=2) or (opcion=3) or (opcion=4);
    
    case opcion of
        1:  writeLn('El texto tiene ',N,' palabras');
        2:  writeLn('La palabra mas larga tiene ',maxLongitud(A,N),' caracteres');
        3:  writeLn('La primera palabra del texto en aparecer en el diccionario es ',primero(A,N));
        4:  
            begin
                frecuencia(A,N,B);
                writeLn('Las frecuencias de cada letra son: ');
                imprimirArreglo(B);
            end;
    end;
        
end.