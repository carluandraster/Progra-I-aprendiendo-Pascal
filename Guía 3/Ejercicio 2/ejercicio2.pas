{Se debe liquidar el sueldo de N empleados, de ellos se sabe el nombre y la antigüedad en años.
Todos parten de un básico de $15000 y la antigüedad se calcula según la siguiente tabla:
- Hasta 5 años …………. 5%
- De 6 a 10 años……….. 8%
- De 11 a 15 años…….. 12%
- Más de 15 años …… 20%
Además se descuenta un 11% por cargas sociales y $500 por seguro obligatorio.
Calcular e informar:
a) Nombre y sueldo de cada empleado.
b) Nombre del empleado que más cobra (suponer que es único).
c) Monto del sueldo promedio. }

Program ejercicio2;

const
    sueldoBasico=15000;
    cargasSociales=0.89;
    seguroObligatorio=500;

var
    // Variables de entrada
        N,anios:byte;
        nombre:string;
    
    // Variables de proceso
        antiguedad,sueldo,sueldoMaximo,acumulador,promedio:real;
        i:byte;
    
    // Variables de salida
        empleadoQueMasCobra:string;
begin
    // Inicializar variables
        acumulador:=0;
        sueldoMaximo:=-1;
    
    // Preguntar por N
        writeLn('¿Cuantos sueldos debe liquidar?');
        readLn(N);
    
    // Ciclo for
        for i:=1 to N do
          begin
            // Preguntar nombre del empleado
                writeLn('Ingrese nombre del empleado');
                readLn(nombre);
            
            // Preguntar años de antigüedad
                writeLn('Ingrese sus años de antiguedad');
                readLn(anios);
            
            // Determinar sueldo neto
                if anios>10 then
                  if anios>15 then
                    antiguedad:=1.2
                  else 
                    antiguedad:=1.12
                else
                  if anios>5 then
                    antiguedad:=1.08
                  else
                    antiguedad:=1.05;
                
                sueldo:=sueldoBasico*antiguedad*cargasSociales-seguroObligatorio;
            
            // Sumar sueldo al acumulador para luego sacar el promedio
                acumulador:=acumulador+sueldo;
            
            // Salida de datos (inciso a)
                writeLn(nombre,' cobra $',sueldo:8:2);
            
            // Registrar nombre del empleado que más cobra (inciso b)
                if sueldo>sueldoMaximo then
                    empleadoQueMasCobra:=nombre;
          end;
    
    // Salida de datos
        // Inciso b
            writeLn('El empleado que mas cobra es ',empleadoQueMasCobra);
        
        // Inciso c
            promedio:=acumulador/N;
            writeLn('El sueldo promedio es de $',promedio);
end.