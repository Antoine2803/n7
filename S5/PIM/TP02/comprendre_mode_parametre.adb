with Ada.Text_IO;
use Ada.Text_IO;

-- Dans ce programme, les commentaires de spécification
-- ont **volontairement** été omis !

procedure Comprendre_Mode_Parametre is

    function Double (N : in Integer) return Integer is
    begin
        return 2 * N;
    end Double;

    procedure Incrementer (N : in out Integer) is
    begin
        N := N + 1;
    end Incrementer;

    procedure Mettre_A_Zero (N : out Integer) is
    begin
        N := 0;
    end Mettre_A_Zero;

    procedure Comprendre_Les_Contraintes_Sur_L_Appelant is
        A, B, R : Integer;
    begin
        A := 5;
        -- Indiquer pour chacune des instructions suivantes si elles sont
        -- acceptées par le compilateur.
        R := Double (A);--v
        R := Double (10);--v
        R := Double (10 * A);--v
        R := Double (B);--f

        Incrementer (A);--a
        --Incrementer (10);--f
        --Incrementer (10 * A);--f
        Incrementer (B);--f

        Mettre_A_Zero (A);--v
        --Mettre_A_Zero (10);--f
        --Mettre_A_Zero (10 * A);--f
        --Mettre_A_Zero (B);--v
    end Comprendre_Les_Contraintes_Sur_L_Appelant;


    procedure Comprendre_Les_Contrainte_Dans_Le_Corps (
            A      : in Integer;
            B1, B2 : in out Integer;
            C1, C2 : out Integer)
    is
        L: Integer;
    begin
        -- pour chaque affectation suivante indiquer si elle est autorisée
        --L := A;--v
        --A := 1;--f

        B1 := 5;---v

        L := B2;--v
        B2 := B2 + 1;--v

        C1 := L;--v

        --L := C2;--f

        C2 := A;--v
        C2 := C2 + 1;--f
    end Comprendre_Les_Contrainte_Dans_Le_Corps;


begin
    Comprendre_Les_Contraintes_Sur_L_Appelant;
    Put_Line ("Fin");
end Comprendre_Mode_Parametre;
