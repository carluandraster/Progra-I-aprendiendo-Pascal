{Desarrollar un procedimiento y los tipos necesarios para el cálculo de una serie finita. Los
parámetros serán:
 N = cantidad de términos a sumar, con N>0
 RES = resultado
 F = función para calcular cada uno de los términos de la serie
El procedimiento calculará: RES = F(1) + F(2) + F(3) +...+ F(n)
y se pide utilizarlo para evaluar por medio de un menú
 RES1 = 1 + 1/4 + 1/9 +...+1/ n2
 RES2 = 1 + 1/2 + 1/4 +...+ 1/ 2 (n-1)
 RES3 = 1 + 1/2! + 1/3! +...+ 1/ n!
Resolver utilizando el tipo función. ¿Cómo cambiaría F por P de tipo procedimiento?}

Program ejercicio15;

type
    F=function(x:byte):real;

// Funciones y procedimientos

function F1(x:byte):real;
begin
    F1:=1/sqr(x);
end;

function potencia(n:byte):longint;
    var
        i:byte;
        productoria:longint;
    begin
        // Inicializar variables
            productoria:=1;
        
        // Calcular potencia
        for i:=1 to n do
          begin
            productoria:=productoria*2;
          end;
        
        // Retornar la productoria total
            potencia:=productoria;
    end;

function F2(x:byte):real;
    begin
        F2:=1/potencia(x-1);
    end;

function factorial(numero:byte):extended;
    begin
        if numero=0 then
            factorial:=1
        else
            factorial:=numero*factorial(numero-1);
    end;

function F3(x:byte):real;
    begin
        F3:=1/factorial(x);
    end;

function serie(n:byte;F:F):real;
    var
        i:byte;
        acumulador:real;
    begin
        acumulador:=0;
        for i:=1 to n do
            acumulador:=acumulador+F(i);
        serie:=acumulador;
    end;

// Programa principal
var
    n,opcion:byte;
    funcion:F;
    suma:real;

begin
    // Menu principal
    repeat
        writeLn('Seleccione una opcion: ');
        writeLn('1- 1/n^2');
        writeLn('2- 1/2^(n-1)');
        writeLn('3- 1/n!');
        readLn(opcion);
    until (opcion=1) or (opcion=2) or (opcion=3);

    // Ingresar n por teclado
    repeat
        writeLn('Ingrese un numero natural');
        readLn(n);
    until n>0;

    // Estructura selectiva
    case opcion of
        1: funcion:=@F1;
        2: funcion:=@F2;
        3: funcion:=@F3;
    end;

    // Calcular suma
    suma:=serie(n,funcion);

    // imprimir sumatoria por pantalla
    writeLn('La sumatoria de 1 hasta ',N,' de la funcion es: ',suma:0:2);

end.