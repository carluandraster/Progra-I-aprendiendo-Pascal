Program ejercicio3;

const
    TOPE = 255;

type
    TV = array[1..TOPE] of integer;

function PosX (V:TV; N: byte;x: integer): byte;
var
    i: byte;
begin
    i:=1;
    while (i<=N) and (V[i]<>x) do
        i:=i+1;
    if i<=N then
        PosX:=i
    else
        PosX:=0;
end;