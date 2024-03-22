{Reescriba el Ej 7, en cada línea del archivo: Nombre (15 caracteres) y las tres notas reales
utilizando archivo de texto para ingreso de datos}

Program ejercicio11b;

 var
    nombre:string[15];
    nota1Str,nota2Str,nota3Str:string[5];
    espacio1,espacio2:char;
    nota1,nota2,nota3,porcentaje,promedio:real;
    contadorAlumnos,contadorAprobados:byte;
    archivo:text;

begin
    // Archivo txt
        assign(archivo,'notas.txt');
        reset(archivo);

    // Inicializar variables
        contadorAlumnos:=0;
        contadorAprobados:=0;
    
    // Lectura del archivo
        while not eof(archivo) do
            begin
                // Contar alumno
                    contadorAlumnos:=contadorAlumnos+1;
                
                // Leer del archivo el nombre y las 3 notas
                    readLn(archivo,nombre,nota1Str,espacio1,nota2Str,espacio2,nota3Str);

                // Convertir las 3 notas a reales
                    val(nota1Str,nota1);
                    val(nota2Str,nota2);
                    val(nota3Str,nota3);
                
                // Calcular promedio
                    promedio:=(nota1+nota2+nota3)/3;
                
                // El alumno aprueba si y solo si su promedio es mayor o igual a 4
                    if promedio>=4 then
                        begin
                            writeLn(nombre,' aprobo con un promedio de ',promedio:4:2);
                            contadorAprobados:=contadorAprobados+1;
                        end
                    else
                        writeLn(nombre,' desaprobo con un promedio de ',promedio:4:2);
            end;
    
    // Comunicar el porcentaje de alumnos aprobados
        porcentaje:=contadorAprobados/contadorAlumnos*100;
        writeLn('El porcentaje de alumnos aprobados fue del ',porcentaje:6:2,'%');
end.