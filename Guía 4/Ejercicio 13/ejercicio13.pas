{Desarrollar un procedimiento que dada una Hora Inicial (horas, minutos, segundos) y unos
segundos transcurridos, devuelva la Hora Final (en horas, minutos y segundos).}

Program ejercicio12;

// Funciones y procedimientos

// Este procedimiento agarra una hora invalida (por ejemplo, 6:78:104) y lo corrige (en el ejemplo a 7:19:44)
Procedure corregirHora(var segundos: word; var minutos, horas: byte);
begin
    if segundos>=60 then
    begin
        minutos:=minutos+segundos div 60;
        segundos:=segundos mod 60;
    end;
    if minutos>=60 then
    begin
        horas:=horas+minutos div 60;
        minutos:= minutos mod 60;
    end;
end;

// Este procedimiento suma hora, minuto y segundos
Procedure sumarHoras(var hora,minuto:byte; var segundo:word; segundosTranscurridos:word);
begin
    segundo:=segundo+segundosTranscurridos;
    corregirHora(segundo,minuto,hora);
end;

// Programa principal

var
    hora,minuto:byte;
    segundosTranscurridos,segundo:word;
    segundoStr,minutoStr:string;

begin
    // Ingresar por teclado y validar tiempo incial

    writeLn('Ingrese la hora incial');
    readLn(hora);

    repeat
        writeLn('Ingrese los minutos inciales');
        readLn(minuto);
    until minuto<60;

    repeat
        writeLn('Ingrese los segundos iniciales');
        readLn(segundo);
    until segundo<60;

    // Ingresar por teclado los segundos transcurridos
    writeLn('Ingrese los segundos transcurridos: ');
    readLn(segundosTranscurridos);

    // Calcular tiempo final
    sumarHoras(hora,minuto,segundo,segundosTranscurridos);
    str(minuto,minutoStr);
    str(segundo,segundoStr);
    if minuto<10 then
        minutoStr:='0'+minutoStr;
    if segundo<10 then
        segundoStr:='0'+segundoStr;

    // Imprimir el tiempo final
    writeLn('Tiempo final: ',hora,':',minutoStr,':',segundoStr);
end.