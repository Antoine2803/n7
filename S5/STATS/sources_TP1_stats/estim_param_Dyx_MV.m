% Fonction estim_param_Dyx_MV (exercice_1.m)

function [a_Dyx,b_Dyx,residus_Dyx] = estim_param_Dyx_MV(x_donnees_bruitees,y_donnees_bruitees,tirages_psi)
    [x_G,y_G,x_centree,y_centree] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees);
    residus = repmat(y_centree,1,length(tirages_psi)) - x_centree * tan(tirages_psi);
    a = sum(residus.^2);
    [~,ind] = min(a);
    a_Dyx = tan(tirages_psi(ind));
    b_Dyx = y_G - a_Dyx * x_G;
    residus_Dyx = residus(:,ind);
end