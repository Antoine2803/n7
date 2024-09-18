% Fonction parametres_correlation (exercice_1.m)

function [r,a,b] = parametres_correlation(Vd,Vg)
    Moy_x = mean(Vd);
    Moy_y = mean(Vg);
    Var_x = (Vd'*Vd)/length(Vd) - Moy_x*Moy_x;
    Var_y = (Vg'*Vg)/length(Vg) - Moy_y*Moy_y;
    Cov_xy = (Vd'*Vg)/length(Vg) - Moy_y*Moy_x;
    r = Cov_xy/(sqrt(Var_x)*sqrt(Var_y));
    a = Cov_xy/Var_x;
    b = Moy_y - a*Moy_x;

end