{Calcular la solución por determinantes de un sistema de dos ecuaciones lineales con dos incógnitas
(se supone compatible y determinado). Desarrollar la función que dados a,b,d,e obtenga x}

Program ejercicio5;

function det(a,b,c,d:real):real;
    begin
      det:=a*d-c*b;
    end;

function sistEcuaciones(a:real;b:real;c:real;d:real;e:real;f:real):real;
    begin
      sistEcuaciones:=det(c,b,f,e)/det(a,b,d,e);
    end;

var
    a,b,c,d,e,f:real;

begin
    // Ingreso de datos por teclado
        writeLn('PRIMERA ECUACION');

            write('Ingrese el coeficiente de x: ');
            read(a);
            
            write('Ingrese el coeficiente de y: ');
            read(b);

            write('Ingrese el termino independiente: ');
            read(c);
        
        writeLn('SEGUNDA ECUACION');

            write('Ingrese el coeficiente de x: ');
            read(d);
            
            write('Ingrese el coeficiente de y: ');
            read(e);

            write('Ingrese el termino independiente: ');
            read(f);
    
    // Resolver sistema de ecuaciones y mostrar en pantalla
        writeLn('x = ',sistEcuaciones(a,b,c,d,e,f):8:2);
end.