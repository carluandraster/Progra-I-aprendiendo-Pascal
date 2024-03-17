{Una empresa le brinda a sus clientes un servicio de cable con un costo básico de $1350 por mes, el
paquete de películas se cobra $200 adicionales y el de deportes $270. Aparte ofrece internet por $800 con
6MB, si se desea 10MB y WIFI cuesta 20% más. La opción de grabar programas tiene un costo adicional
de $150 por mes. La promoción es que si se contrata ambos servicios (cable e internet), tiene una
bonificación del 25% del total.
Ingresar los datos de un cliente, calcular e informar cuánto debe pagar.}

Program ejercicio10;

const
    costoBasico=1350;
    paqueteDePeliculas=200;
    paqueteDeDeportes=270;
    internet=800;
    grabarProgramas=150;
    bonificacion=0.75;

var
    // Variables de entrada
        respuestaPeli,respuestaDeportes,respuestaInternet,respuestaGrabar:char;
        opcionInternet:byte;

    // Precio
        precio:real;

begin
    // Entrada de datos
        // Preguntar si quiere el paquete de peliculas
            writeLn('¿Desea el paquete de peliculas? (S o N)');
            readLn(respuestaPeli);
            respuestaPeli:=upcase(respuestaPeli);
        
        // Preguntar si quiere el paquete de deportes
            writeLn('¿Desea el paquete de deportes? (S o N)');
            readLn(respuestaDeportes);
            respuestaDeportes:=upcase(respuestaDeportes);
        
        // Preguntar si quiere la opción de grabar programas
            writeLn('¿Quiere la opcion de grabar programas?');
            readLn(respuestaGrabar);
            respuestaGrabar:=upcase(respuestaGrabar);

    // Procesar tarifa
        // Inicializar precio
            precio:=costoBasico;
        
        // Sumar el paquete de peliculas si corresponde
            if respuestaPeli='S' then
                precio:=precio+paqueteDePeliculas;
        
        // Sumar el paquete de deportes si corresponde
            if respuestaDeportes='S' then
                precio:=precio+paqueteDeDeportes;

        // Sumar la opcion de grabar programas si corresponde
            if respuestaGrabar='S' then
                precio:=precio+grabarProgramas;
        
        // Preguntar si quiere internet
            writeLn('¿Desea el servicio de Internet? (S o N)');
            readLn(respuestaInternet);
            respuestaInternet:=upcase(respuestaInternet);

        // Sumar el servicio de internet si corresponde
            if respuestaInternet='S' then
                begin
                    // Preguntar tipo de servicio de Internet
                        writeLn('Seleccione un servicio de Internet');
                        writeLn('1- Internet 6 MB');
                        writeLn('2- Internet 10 MB + WiFi');

                        readLn(opcionInternet);
                    
                    // Sehun el tipo de Internet, se aplican tarifas distintas
                    if opcionInternet=1 then
                        precio:=precio+internet
                    else
                        if opcionInternet=2 then
                            precio:=precio+internet*1.2;

                    // Si se contrata ambos servicios (cable e internet), tiene una bonificación
                        precio:=precio*bonificacion;
                end;
        
    // Salida de datos
        writeLn('La tarifa que debera pagar es de $',precio:7:2);
end.