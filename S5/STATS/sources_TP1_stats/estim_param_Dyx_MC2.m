% Fonction estim_param_Dyx_MC2 (exercice_2bis.m)

function [a_Dyx,b_Dyx,coeff_r2] = ...
                   estim_param_Dyx_MC2(x_donnees_bruitees,y_donnees_bruitees)
    x_G = mean(x_donnees_bruitees);
    y_G = mean(y_donnees_bruitees);
    vx = mean(x_donnees_bruitees.^2) - x_G^2;
    vy = mean(y_donnees_bruitees.^2) - y_G^2;
    cxy = mean(x_donnees_bruitees.*y_donnees_bruitees) - y_G*x_G;
    r = cxy/sqrt(vx*vy);
    a_Dyx = r * sqrt(vy/vx);
    coeff_r2 = r^2;

    b_Dyx = y_G - a_Dyx*x_G;    
end