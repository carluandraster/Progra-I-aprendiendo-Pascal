Program ejercicio2;

const
    CANTPROV = 23;
    CENTINELA = 'zzzzzzzzzz';

type
    // Cadenas de texto
    str10 = string[10];
    str20 = string[20];

    // MUDANZAS.DAT
    TRM = record
        empresa: str10;
        cod_provincia,cant_paq_envio: byte;
        peso_envio,costo_envio: real;
    end;
    TAM = file of TRM;

    // PROVINCIA.DAT
    TRP = record
        cod_provincia: byte;
        nombre: str20;
    end;
    TAP = file of TRP;

    // Vector Provincias
    TRPA = record
        nombre: str20;
        paquetes: word;
    end;
    TV = array [1..CANTPROV] of TRPA;

    // Corte de control
    TRE = record
        empresa: str10;
        paquetes: word;
    end;
    TRPM = record
        provincia: str20;
        montoTotal: real;
    end;

// Subprogramas

procedure cargarMudanzas (var MUDANZAS: TAM);
var
    registro: TRM;
    archivo: text;
begin
    // Abrir archivos
    assign(archivo,'./txt/MUDANZAS.TXT');
    reset(archivo);
    rewrite(MUDANZAS);

    // Pasar datos
    while not eof(archivo) do
    begin
        with registro do
        begin
            read(archivo,empresa);
            if empresa<>CENTINELA then
                read(archivo,cod_provincia,cant_paq_envio,peso_envio,costo_envio);
        end;  
        write(MUDANZAS,registro);
        readLn(archivo);
    end;

    // Cerrar archivo
    close(archivo);
    close(MUDANZAS);
end;

procedure cargarProvincias (var PROVINCIA: TAP);
var
    archivo: text;
    registro: TRP;
    blanco: char;
begin
    // Abrir archivos
    assign(archivo,'./txt/PROVINCIA.TXT');
    reset(archivo);
    rewrite(PROVINCIA);

    // Pasar datos
    while not eof(archivo) do
    begin
        with registro do
            readLn(archivo,cod_provincia,blanco,nombre);
        write(PROVINCIA,registro);
    end;

    // Cerrar archivos
    close(archivo);
    close(PROVINCIA);
end;



procedure leerProvincias (var PROVINCIAS: TV; var PROVINCIA: TAP);
var
    registro: TRP;
begin
    // Abrir archivo
    reset(PROVINCIA);

    // Leer archivo
    while not eof(PROVINCIA) do
    begin
        read(PROVINCIA,registro);
        with PROVINCIAS[registro.cod_provincia] do
        begin
            nombre:=registro.nombre;
            paquetes:=0;
        end;
    end;

    // Cerrar archivo
    close(PROVINCIA);
end;

procedure corte (
    var MUDANZAS: TAM;
    var maxEmpresa: TRE;
    var PROVINCIAS: TV
);
var
    VC1: str10;
    VC2: byte;
    totalPaquetes,contador: word;
    pesoTotal,montoTot,acumulador: real;
    maxProvincia: TRPM;
    registro: TRM;
begin
    // Abrir archivo
    reset(MUDANZAS);

    // Inicializar variables
    maxEmpresa.paquetes:=0;

    // Leer archivo
    read(MUDANZAS,registro);    
    while not eof(MUDANZAS) do
    begin
        writeLn('Empresa ',registro.empresa);
        // Inicializar variables
        VC1:=registro.empresa;
        acumulador:=0;
        contador:=0;
        maxProvincia.montoTotal:=0;
        writeLn('Provincia 	Total de Paquetes  	Peso Total	Monto Total');
        while (VC1=registro.empresa) and not eof(MUDANZAS) do
        begin
            totalPaquetes:=0;
            pesoTotal:=0;
            montoTot:=0;
            VC2:=registro.cod_provincia;
            while (VC2=registro.cod_provincia) and (VC1=registro.empresa) and not eof(MUDANZAS) do
            begin
                totalPaquetes:=totalPaquetes+registro.cant_paq_envio;
                pesoTotal:=pesoTotal+registro.peso_envio;
                montoTot:=montoTot+registro.costo_envio;
                read(MUDANZAS,registro);
            end;
            writeLn(PROVINCIAS[VC2].nombre,'          ',totalPaquetes:(15-length(PROVINCIAS[VC2].nombre)),
            '                  ',pesoTotal:5:2,'         $',montoTot:5:2);
            PROVINCIAS[VC2].paquetes:=PROVINCIAS[VC2].paquetes+totalPaquetes;
            if montoTot>maxProvincia.montoTotal then
                with maxProvincia do
                begin
                    provincia:=PROVINCIAS[VC2].nombre;
                    montoTotal:=montoTot;
                end;
            acumulador:=acumulador+pesoTotal;
            contador:=contador+totalPaquetes;
        end;
        writeLn('Peso promedio por paquete: ',acumulador/contador:5:2);
        writeLn('Provincia destino con mayor monto total: ',maxProvincia.provincia);
        if contador>maxEmpresa.paquetes then
            with maxEmpresa do
            begin
                empresa:=VC1;
                paquetes:=contador;
            end;     
    end;

    // Cerrar archivo
    close(MUDANZAS);
end;

function maximo (PROVINCIAS: TV; N: byte): byte;
var
    maxAux: byte;
begin
    if N=1 then
        maximo:=1
    else
        begin
            maxAux:=maximo(PROVINCIAS,N-1);
            if PROVINCIAS[N].paquetes>PROVINCIAS[maxAux].paquetes then
                maximo:=N
            else
                maximo:=maxAux;
        end;
end;


// Programa principal

var
    MUDANZAS: TAM;
    PROVINCIA: TAP;
    PROVINCIAS: TV;
    maxEmpresa: TRE;

begin
    // Asignar archivos
    assign(MUDANZAS,'./dat/MUDANZAS.DAT');
    assign(PROVINCIA,'./dat/PROVINCIA.DAT');

    // Cargar archivos
    cargarMudanzas(MUDANZAS);
    cargarProvincias(PROVINCIA);

    // Leer provincias
    leerProvincias(PROVINCIAS,PROVINCIA);

    // Listado
    corte(MUDANZAS,maxEmpresa,PROVINCIAS);

    // Mensaje final
    writeLn('La empresa ',maxEmpresa.empresa,' es la que mas paquetes transporto.');
    writeLn(PROVINCIAS[maximo(PROVINCIAS,CANTPROV)].nombre,' es la provincia destino con mayor recepcion de paquetes');
end.