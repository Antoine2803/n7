with Ada.Text_IO;          use Ada.Text_IO;
with Ada.Integer_Text_IO;  use Ada.Integer_Text_IO;

procedure Principal is
    function Nbj_mois (M : in Integer) return Integer with
        pre => M > 0 and M<=12
    is
    begin
        case M is
            When 1 | 3 | 5 | 7 | 8 | 10 | 12 => return 31;
            when 4 | 6 | 9 | 11 => return 30;
            when others => return 28;
        end case;
    end Nbj_mois;

    procedure Jour_suivant (J,M,A: in out Integer) is
        Nbj_m : Integer;
    begin
        Nbj_m := Nbj_mois(M);
        if J = Nbj_m then 
            if M = 12 then
                A := A +1;
                M := 1;
                J := 1;
            else
                M := M +1;      
                J := 1;
            end if;
        else
            J := J +1;
        end if;
    end Jour_suivant;

    procedure Test_Nbj_mois is
    begin
        pragma Assert(Nbj_mois(12) = 31);
        pragma Assert(Nbj_mois(4) = 30);
        pragma Assert(Nbj_mois(10) = 31);
        pragma Assert(Nbj_mois(2) = 28);
    end Test_Nbj_mois;

    procedure Test_Jour_suivant is
        A,M,J : Integer;
    begin 
        A:= 2222;
        M:=12;
        J:=30;
        Jour_suivant(J,M,A);   
        pragma Assert (A = 2222 and M = 12 and j = 31);
        Jour_suivant(J,M,A);
        pragma Assert (A = 2223 and M = 1 and j = 1);
    end Test_Jour_suivant;
begin
    Test_Jour_suivant;
    Test_Nbj_mois;

end Principal;