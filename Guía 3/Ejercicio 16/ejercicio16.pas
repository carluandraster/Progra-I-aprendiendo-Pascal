{Una empresa de autos de alquiler posee N vehículos y ha registrado la siguiente información de los
viajes realizados, por cada uno de ellos:
 - Patente
 - Total de litros de combustible consumidos
Y por cada viaje realizado
 - Kilómetros recorridos. (0 indica fin de datos).
Se pide ingresar los datos e informar:
a) Por cada vehículo el consumo que tuvo (cantidad de litros por km. recorrido)
b) Patente del vehículo que más viajes hizo.
c) Total de litros consumidos por el auto que hizo la menor cantidad de kms. }

Program ejercicio16;

var
    // Variables de entrada
        N:byte;
        patente:string;
        distancia,combustible:real;
    
    // Variables de proceso
        i,maxViajes,contadorDeViajes:byte;
        acumuladorDistancia,minDistancia:real;
    
    // Variables de salida
        consumo,minCombustible:real;
        patenteMax:string;

begin
    // Inicializar variables
        maxViajes:=0;
        minDistancia:=99999999999;
    
    // Preguntar y validar N
        repeat
          writeLn('Ingrese cantidad de vehiculos: ');
          readLn(N);
        until N>0;
    
    // Preguntar información para cada uno de los N vehículos
        for i:=1 to N do
          begin
            // Inicializar variables
                acumuladorDistancia:=0;
                contadorDeViajes:=0;
            
            // Preguntar patente
                writeLn('Ingrese patente: ');
                readLn(patente);
            
            // Preguntar y validar combustible
                repeat
                  writeLn('Ingrese total de litros de combustible consumidos: ');
                  readLn(combustible);
                until combustible>0;
            
            // Preguntar por cada viaje. Como no sabemos la cantidad de viajes, usaremos un ciclo repetir hasta que
                repeat
                    repeat
                        writeLn('Ingrese kilometros recorridos: ');
                        readLn(distancia);
                    until distancia>=0;
                    if distancia<>0 then
                      begin
                        contadorDeViajes:=contadorDeViajes+1;
                        acumuladorDistancia:=acumuladorDistancia+distancia;
                      end;
                until distancia=0;
            
            // Calcular e informar consumo por kilómetro recorrido (inciso a)
                consumo:=combustible/acumuladorDistancia;
                writeLn('El vehiculo gasto ',consumo:8:2,' litros por kilometro recorrido.');
            
            // ¿Es el vehículo que más viajes hizo? (inciso b)
                if contadorDeViajes>maxViajes then
                    begin
                      maxViajes:=contadorDeViajes;
                      patenteMax:=patente;
                    end;
            
            // ¿Es el auto que hizo la menor cantidad de kms? (inciso c)
                if distancia<minDistancia then
                    begin
                      minDistancia:=distancia;
                      minCombustible:=combustible;
                    end;
          end;
    
    // Salida de datos
        writeLn('El vehiculo que mas viajes hizo fue la patente ',patenteMax);
        writeLn('El auto que hizo la menor cantidad de kilometros gasto ',minCombustible:8:2,' litros de combustible');
end.