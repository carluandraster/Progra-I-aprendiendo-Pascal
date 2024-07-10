Program ejercicio1;

const
    TOPE = 10;
    CENTINELA = 9999;

type
    // Cadenas de texto
    str3 = string[3];
    str4 = string[4];
    str8 = string[8];
    str30 = string[30];

    // EMPLEADOS.DAT
    TRE = record
        legajo: str4;
        nombre: str30;
        sueldo: real;
    end;
    TAE = file of TRE;

    // HORAS-TRABAJO.DAT
    TRH = record
        legajo: str4;
        fecha: str8;
        horas: real;
        codPozo: str3;
    end;
    TAH = file of TRH;

    // Pozo-Petrolero.dat
    TRP = record
        codPozo: str3;
        descripcion: str30;
        valorHora: real;
    end;
    TAP = file of TRP;

    // Vector pozos petroleros
    TRPA = record
        codPozo: str3;
        descripcion: str30;
        valorHora,horas,monto: real;
    end;
    TV = array [1..TOPE] of TRPA;