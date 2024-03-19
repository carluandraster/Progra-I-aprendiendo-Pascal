{Dado un conjunto de alumnos, no se sabe cuántos son, de cada uno de ellos se conoce:
- Nombre (‘***’ indica fin de datos)
- Nota1, Nota2 y Nota3
Ingresar la información e informar:
a) El promedio de cada alumno y su condición:
− ‘Aprobado’ si su promedio es mayor o igual a 4
− ‘Desaprobado’ si su promedio es menor a 4.
 b) Porcentaje de alumnos Aprobados }

 Program ejercicio7;

 var
    nombre:string;
    nota,acumuladorNota,promedio,porcentaje:real;
    contadorAlumnos,contadorAprobados,i:byte;

begin
    // Inicializar variables
        contadorAlumnos:=0;
        contadorAprobados:=0;
    
    // Preguntar nombre del primer alumno
        writeLn('Ingrese el nombre del alumno');
        readLn(nombre);
    
    // Ciclo repetir hasta que
        repeat
            // Contar alumno
                contadorAlumnos:=contadorAlumnos+1;
            
            // Resetear acumulador de nota
                acumuladorNota:=0;

            // Preguntar y validar las 3 notas
               for i:=1 to 3 do
                 begin
                   repeat
                     writeLn('Ingrese nota ',i);
                     readLn(nota);
                   until (nota>=1) and (nota<=10);
                   // Acumular nota
                        acumuladorNota:=acumuladorNota+nota;
                 end;
            
            // Calcular promedio
                promedio:=acumuladorNota/3;
            
            // El alumno aprueba si y solo si su promedio es mayor o igual a 4
                if promedio>=4 then
                  begin
                    writeLn(nombre,' aprobo con un promedio de ',promedio:4:2);
                    contadorAprobados:=contadorAprobados+1;
                  end
                else
                    writeLn(nombre,' desaprobo con un promedio de ',promedio:4:2);
            
            // Preguntar el nombre del siguiente alumno
                writeLn('Ingrese el nombre del alumno');
                readLn(nombre);
        until nombre='***';
    
    // Comunicar el porcentaje de alumnos aprobados
        porcentaje:=contadorAprobados/contadorAlumnos*100;
        writeLn('El porcentaje de alumnos aprobados fue del ',porcentaje:6:2,'%');
end.