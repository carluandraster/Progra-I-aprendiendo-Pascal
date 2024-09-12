Program parcial;

type
    str10 = string[10];

var
    X,puntaje,dado1,dado2,conta6,contaGral,N,i: byte;
    archivo: text;
    nombre: str10;
    tiene6: boolean;

begin
    conta6 := 0;
    contaGral := 0;

    // Ingresar X
    writeLn('Ingrese un puntaje: ');
    readLn(X);

    // Abrir archivo
    assign(archivo,'Juego.TXT');
    reset(archivo);
    readLn(archivo,N);
    readLn(archivo,nombre);
    while nombre <> 'XXX' do
    begin
        puntaje := 0;
        tiene6 := false;
        for i:=1 to N do
        begin
            readLn(archivo,dado1,dado2);
            // Inciso a
            if dado1 = dado2 then
                puntaje := puntaje +3*(dado1+dado2)
            else
                if abs(dado1-dado2) = 1 then
                    puntaje := puntaje + 2*(dado1+dado2)
                else
                    puntaje := puntaje + dado1+dado2;
            // Inciso b
            if (dado1 = 6) or (dado2 = 6) then
                tiene6 := true;
        end;
        
        writeLn('El jugador ',nombre,' obtuvo ',puntaje,' puntos.');
        readLn(archivo,nombre);
        if puntaje<X then
        begin
            contaGral := contaGral+1;
            if tiene6 then
                conta6 := conta6 +1;
        end;
    end;
    close(archivo);
    if contaGral>0 then
        writeLn('Porcentaje de los jugadores que sacaron al menos un 6: ',conta6/contaGral*100:8:2,'%')
    else
        writeLn('Ningun jugador saco menos de ',X,' puntos');
end.