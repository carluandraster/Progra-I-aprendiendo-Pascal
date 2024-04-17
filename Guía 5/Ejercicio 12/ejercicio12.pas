{En un archivo de texto se ha grabado por cada línea, una cadena (es una clave encriptada que
puede contener letras, números y caracteres especiales (&, $, #, etc.), y que siempre termina en
letra), luego uno o más blancos y tres números separados por blancos, por último uno o más
blancos y una letra.
Ejemplo: mU&1#hT34*A 80 40 30 P
Se pide, a partir del archivo, cargar tres arreglos paralelos:
• VClave contendrá las claves sin los caracteres especiales, que registren en su encriptación
hasta tres caracteres especiales (las claves que tengan más de tres invalidan la información de
la línea, que no se almacena)
• VProm almacena el promedio de los tres números.
• VCar almacena el caracter que está al final de la línea, siempre que no coincida con la última
letra de la clave, en cuyo caso invalida la información de la línea, que no se almacena)
Mostrar los arreglos generados, y luego para una letra y una clave que se ingresan por teclado:
a) Para la letra ingresada, calcular e informar la clave de máximo promedio.
b) Para la clave ingresada, informar el promedio y la letra asociada (puede no existir) }

Program ejercicio12;

const
    tope=255;

type
    TVstr = array[1..tope] of string;
    TVreal = array[1..tope] of real;
    TVcar = array[1..tope] of char;

// Subprogramas

// Función booleana que devuelve verdadero cuando el caracter es especial
function esEspecial(x:char):boolean;
begin
    if (x in ['a'..'z']) or (x in ['A'..'Z']) or (x in ['0'..'9']) then
        esEspecial:=false
    else
        esEspecial:=true;
end;

// Se pide, a partir del archivo, cargar tres arreglos paralelos
procedure leerArchivo(var A:TVstr; var B:TVreal; var C:TVcar; var N:byte);
var
    i,j,contador,suma,num:byte;
    archivo:text;
    caracter,ultimo:char;
begin
    // Inicializar variable de control
    i:=1;

    // Reconocer archivo de texto
    assign(archivo,'claves.txt');
    reset(archivo);

    // Leer archivo
    while not eof(archivo) do
    begin
        // Inicializar variables
        contador:=0;
        suma:=0;
        A[i]:='';

        // Leer codigo
        read(archivo,caracter);
        while (caracter<>' ') and (contador<=3) do
        begin
            if esEspecial(caracter) then
                contador:=contador+1
            else
                A[i]:=A[i]+caracter;
            ultimo:=caracter;
            read(archivo,caracter);
        end;

        // Leer numeros y sacar un promedio
        if contador<=3 then
        begin
            for j:=1 to 3 do
            begin
                read(archivo,num);
                suma:=suma+num;
            end;

            B[i]:=suma/3;

            // Leer caracter
            repeat
                read(archivo,C[i]);
            until C[i]<>' ';

            if C[i]<>ultimo then
                // Incrementar en 1 la variable de control
                i:=i+1;
        end;
        // Saltar linea
        readLn(archivo);
    end;

    // Devolver cantidad de posiciones significativas
    N:=i-1;

    // Cerrar archivo
    close(archivo);
end;

// Mostrar los arreglos generados

// Arreglo de claves
procedure imprimirArrStr(A: TVstr; N:byte);
var
    i:byte;
begin
    write('Codigos: ');
    for i:=1 to N do
        write(A[i],' ');
    writeLn();
end;

// Arreglo de promedios
procedure imprimirArrReal(A: TVreal; N:byte);
var
    i:byte;
begin
    write('Promedios: ');
    for i:=1 to N do
        write(A[i]:0:2,' ');
    writeLn();
end;

// Arreglo de caracteres
procedure imprimirArrCar(A: TVcar; N:byte);
var
    i:byte;
begin
    write('Caracteres: ');
    for i:=1 to N do
        write(A[i],' ');
    writeLn();
end;

// Busqueda

// Para el arreglo de codigos
function buscarS(x:string;A:TVstr;N:byte):byte;
var
    i:byte;
begin
    // Inicializar variable de control
    i:=1;

    // Recorrer arreglo
    while (i<=N) and (A[i]<>x) do
        i:=i+1;
    
    // Devolver resultado
    if A[i]=x then
        buscarS:=i
    else
        buscarS:=0;
end;

// a) Para la letra ingresada, calcular e informar la clave de máximo promedio.
function cmp(x:char;A:TVstr;B:TVreal;C:TVcar;N:byte):string;
var
    maximo:real;
    i:byte;
begin
    // Inicializar variables
    maximo:=-1;
    
    // Recorrer arreglo de caracteres
    for i:=1 to N do
        if (C[i]=x) and (B[i]>maximo) then
        begin
            maximo:=B[i];
            cmp:=A[i];
        end;
    
    // Es posible que no exista ese caracter en nuestro array
    if maximo=-1 then
        cmp:='No se encontro el caracter. Lo sentimos.';
end;

// b) Para la clave ingresada, informar el promedio y la letra asociada (puede no existir)
procedure informacion(x:string; A:TVstr;B:TVreal;C:TVcar;N:byte);
var
    i:byte;
begin
    i:=buscarS(x,A,N);
    if i>0 then
    begin
        writeLn('Promedio: ',B[i]:0:2);
        writeLn('Letra asociada: ',C[i]);
    end
    else
        writeLn('Lo sentimos pero la clave ingresada no se encuentra en nuestra base de datos');
end;

// Programa principal

var
    VClave: TVstr;
    VProm: TVreal;
    VCar: TVcar;
    N:byte;
    clave,maxClave:string;
    caracter:char;

begin
    leerArchivo(VClave,VProm,VCar,N);
    imprimirArrStr(VClave,N);
    imprimirArrReal(VProm,N);
    imprimirArrCar(VCar,N);

    // Inciso a
    writeLn('Ingrese una letra: ');
    readLn(caracter);
    maxClave:=cmp(caracter,VClave,VProm,VCar,N);
    if maxClave<>'No se encontro el caracter. Lo sentimos.' then
        writeLn('La clave de máximo promedio para el caracter ',caracter,' es ',maxClave)
    else
        writeLn(maxClave);
    
    // Inciso b
    writeLn('Ingrese una clave: ');
    readLn(clave);
    informacion(clave,VClave,VProm,VCar,N);
end.