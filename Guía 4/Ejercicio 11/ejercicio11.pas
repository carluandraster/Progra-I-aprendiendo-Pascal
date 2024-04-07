{Dada la ecuación de una parábola y=ax² + bx +c, escribir un programa que mediante un menú de
opciones iterativo permita:
a) Encontrar el eje de simetría, sabiendo que x1 = -b/(2.a) y si presenta un mínimo ó un máximo en
f(x1).
b) Informar hacia dónde es abierta la parábola.
c) Calcular y mostrar las raíces, informar en caso que no existan. Para ello debe analizar si el
discriminante, D = b²– 4ac, es mayor, menor ó igual a cero.
d) Dado un conjunto de valores de x informar su imagen.
Usar procedimientos y/o funciones según corresponda}

Program ejercicio11;

// Funciones y procedimientos

// Inciso a
Function ejeDeSimetria(a,b:real):   real;
Begin
    ejeDeSimetria := -b/(2*a);
End;

Function extremo(a:real):   string; {Criterio de la derivada segunda}
Begin
    If (a>0) Then
        extremo:='minimo'
    Else {Importante que en el programa principal se valida que a sea distinto de 0}
        extremo:='maximo';
End;

// Inciso b
Function concavidad(a:real):string;
begin
  If (a>0) Then
        concavidad:='arriba'
    Else {Importante que en el programa principal se valida que a sea distinto de 0}
        concavidad:='abajo';
end;

// Inciso c
Procedure raices(a,b,c:real;var raiz1,raiz2:real; var error:boolean);
var
    discriminante:real;
begin
  discriminante:=sqr(b)-4*a*c;
  error:=discriminante<0;
  if not error then
    begin
      raiz1:=(-b+sqrt(discriminante))/(2*a);
      raiz2:=(-b-sqrt(discriminante))/(2*a);
    end;
end;

// Inciso d
function imagen (x,a,b,c:real):real;
begin
  imagen:=a*sqr(x)+b*x+c;
end;

// Programa principal

var
    a,b,c,raiz1,raiz2,x:real;
    opcion:byte;
    error:boolean;

begin
    // Ingreso de datos
    writeLn('Sea la parabola y=ax^2+bx+c, ingrese a, b y c: ');
    repeat
      readLn(a);
    until a<>0;
    readLn(b,c);

    // Menu iterativo
      // Validar menu
        repeat
            writeLn('Ingrese una opcion: ');
            writeLn('1 - Encontrar el eje de simetria y ver si es un minimo o un maximo');
            writeLn('2 - Informar hacia donde es abierta la parabola');
            writeLn('3 - Calcular las raices');
            writeLn('4 - Hallar una imagen');
            writeLn('5 - Salir');
            readLn(opcion);
        until (opcion=1) or (opcion=2) or (opcion=3) or (opcion=4) or (opcion=5);
    while opcion<>5 do
        begin
          case opcion of
            1: writeLn('El eje de simetria es ',ejeDeSimetria(a,b):0:2,' y es un ',extremo(a));
            2: writeLn('La parabola es concava hacia ',concavidad(a));
            3:
              begin
                raices(a,b,c,raiz1,raiz2,error);
                if not error then
                  if raiz1=raiz2 then
                    writeLn('La raiz de la parabola es ',raiz1:0:2)
                  Else
                    writeLn('Las raices de la parabola son ',raiz1:0:2,' y ',raiz2:0:2)
                Else
                  writeLn('La parabola no tiene raices reales');
              end;
            4:
              begin
                write('Ingrese el valor de x: ');
                read(x);
                writeLn('La imagen de ',x:0:2,' es ',imagen(x,a,b,c):0:2);
              end;
          end;
        
        // Menu
        repeat
            writeLn('Ingrese una opcion: ');
            writeLn('1 - Encontrar el eje de simetria y ver si es un minimo o un maximo');
            writeLn('2 - Informar hacia donde es abierta la parabola');
            writeLn('3 - Calcular las raices');
            writeLn('4 - Hallar una imagen');
            writeLn('5 - Salir');
            readLn(opcion);
        until (opcion=1) or (opcion=2) or (opcion=3) or (opcion=4) or (opcion=5);
        end;
end.