Program ejercicio1;

const
    TOPE = 100;
    CENTINELA = 'zzzzz';
    
type
    str5 = string[5];
    str20 = string[20];
    TRcarreras = record
        escuderia: str5;
        nombre: str20;
        tiempo: word;
    end;
    TAcarreras = file of TRcarreras;
    TRhistorico = record
        escuderia: str5;
        carrerasGan: byte;
        tiempo: word;
    end;
    TAhistorico = file of TRhistorico;
    TV = array[1..TOPE] of str5;

// Subprogramas

procedure cargarCarreras(var CARRERAS: TAcarreras);
var
    archivo: text;
    blanco: char;
    registro: TRcarreras;
begin
    // Abrir archivos
    assign(archivo,'./txt/CARRERAS.txt');
    reset(archivo);
    rewrite(CARRERAS);

    // Leer archivo
    with registro do
    begin
        read(archivo,escuderia);
        while escuderia<>CENTINELA do
            begin
                read(archivo,blanco,nombre,tiempo);
                write(CARRERAS,registro);
                readLn(archivo);
                read(archivo,escuderia);
            end;
    end;
    write(CARRERAS,registro);

    // Cerrar archivos
    close(archivo);
    close(CARRERAS);
end;

procedure cargarHistorico (var HISTORICO: TAhistorico);
var
    archivo: text;
    registro: TRhistorico;
begin
    // Abrir archivos
    assign(archivo,'./txt/HISTORICO.txt');
    reset(archivo);
    rewrite(HISTORICO);

    // Leer archivo
    with registro do
    begin
        read(archivo,escuderia);
        while escuderia<>CENTINELA do
        begin
            read(archivo,carrerasGan,tiempo);
            write(HISTORICO,registro);
            readLn(archivo);
            read(archivo,escuderia);
        end;
    end;
    write(HISTORICO,registro);

    // Cerrar archivos
    close(archivo);
    close(HISTORICO);
end;

procedure enfrentamiento (var CARRERAS: TAcarreras; var HISTORICO: TAhistorico; var NOGANARON: TV; var N: byte; var mejor: TRcarreras);
var
    TEMP: TAhistorico;
    regCarreras: TRcarreras;
    regHistorico,regTemp: TRhistorico;
    contaVictorias: byte;
    promedio,acumulador: word;
    VC: str5;
begin
    // Abrir archivos
    assign(TEMP,'./dat/TEMP.DAT');
    rewrite(TEMP);
    reset(CARRERAS);
    reset(HISTORICO);

    // Leer archivos
    read(CARRERAS,regCarreras);
    read(HISTORICO,regHistorico);
    mejor:=regCarreras;
    contaVictorias:=0;
    acumulador:=0;
    N:=0;
    while not eof(CARRERAS) or not eof(HISTORICO) do
        // Si es la primera vez que la escudería participa, la agregamos
        if regCarreras.escuderia<regHistorico.escuderia then
            begin
                VC:=regCarreras.escuderia;
                while regCarreras.escuderia=VC do
                    begin
                        contaVictorias:=contaVictorias+1;
                        acumulador:=acumulador+regCarreras.tiempo;
                        if regCarreras.tiempo<mejor.tiempo then
                            mejor:=regCarreras;
                        read(CARRERAS,regCarreras);
                    end;
                with regTemp do
                    begin
                        escuderia:=VC;
                        carrerasGan:=contaVictorias;
                        tiempo:=acumulador div contaVictorias;
                    end;
                write(TEMP,regTemp);

                contaVictorias:=0;
                acumulador:=0;
            end
        else
            if regCarreras.escuderia>regHistorico.escuderia then
            begin
                if contaVictorias=0 then
                    begin
                        N:=N+1;
                        NOGANARON[N]:=regHistorico.escuderia;
                        write(TEMP,regHistorico);
                    end
                else
                    begin
                        with regTemp do
                            begin
                                escuderia:=regHistorico.escuderia;
                                carrerasGan:=regHistorico.carrerasGan+contaVictorias;
                                promedio:=acumulador div contaVictorias;
                                if promedio<regHistorico.tiempo then
                                    tiempo:=promedio
                                else
                                    tiempo:=regHistorico.tiempo;
                            end;
                        write(TEMP,regTemp);

                        contaVictorias:=0;
                        acumulador:=0;
                    end;
                read(HISTORICO,regHistorico);
            end
            else
                begin
                    contaVictorias:=contaVictorias+1;
                    acumulador:=acumulador+regCarreras.tiempo;
                    if regCarreras.tiempo<mejor.tiempo then
                        mejor:=regCarreras;
                    read(CARRERAS,regCarreras);
                end;
    with regTemp do
        escuderia:=CENTINELA;
    write(TEMP,regTemp);
    
    // Cerrar archivos
    close(CARRERAS);
    close(HISTORICO);
    close(TEMP);

    erase(HISTORICO);
    rename(TEMP,'./dat/HISTORICO.DAT');
end;

procedure mostrarArreglo(texto: string;vector: TV; N: byte);
var
    i:byte;
begin
    writeLn(texto);
    for i:=1 to N do
        writeLn(vector[i]);
end;

procedure verificarHistorico (var HISTORICO: TAhistorico);
var
    archivo: text;
    registro: TRhistorico;
begin
    assign(archivo,'./txt/HISTORICO_actualizado.txt');
    rewrite(archivo);
    reset(HISTORICO);
    while not eof(HISTORICO) do
        begin
            read(HISTORICO,registro);
            with registro do
                begin
                    write(archivo,escuderia);
                    if escuderia<>CENTINELA then
                    begin
                        write(archivo,' ',carrerasGan,' ',tiempo);
                        writeLn(archivo);
                    end;
                end;
        end;
    close(HISTORICO);
    close(archivo);
end;

// Programa principal

var
    CARRERAS: TAcarreras;
    HISTORICO: TAhistorico;
    NOGANARON: TV;
    N: byte;
    mejor: TRcarreras;

begin
    // Archivos
    assign(HISTORICO,'./dat/HISTORICO.DAT');
    assign(CARRERAS,'./dat/CARRERAS.DAT');
    cargarCarreras(CARRERAS);
    cargarHistorico(HISTORICO);

    enfrentamiento(CARRERAS,HISTORICO,NOGANARON,N,mejor);

    mostrarArreglo('Escuderias que no ganaron carreras en el ultimo anio: ',NOGANARON,N);
    writeLn('Mejor tiempo en el ultimo anio: ',mejor.nombre,'   ',mejor.escuderia);

    verificarHistorico(HISTORICO);
end.