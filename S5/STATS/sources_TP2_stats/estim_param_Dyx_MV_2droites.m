    % Fonction estim_param_Dyx_MV_2droites (exercice_2.m) 

function [a_Dyx_1,b_Dyx_1,a_Dyx_2,b_Dyx_2] = ... 
         estim_param_Dyx_MV_2droites(x_donnees_bruitees,y_donnees_bruitees,sigma, ...
                                     tirages_G_1,tirages_psi_1,tirages_G_2,tirages_psi_2)    
    
    residus = log(exp(-(y_donnees_bruitees - tirages_G_1(2,:) - tan(tirages_psi_1).*(x_donnees_bruitees - tirages_G_1(1,:))).^2/(2*sigma^2)) ...
            + exp(-(y_donnees_bruitees - tirages_G_2(2,:) - tan(tirages_psi_2).*(x_donnees_bruitees - tirages_G_2(1,:))).^2/(2*sigma^2)));


    a = sum(residus);
    [~,ind] = max(a);
    a_Dyx_1 = tan(tirages_psi_1(ind));
    a_Dyx_2 = tan(tirages_psi_2(ind));
    b_Dyx_1 = tirages_G_1(2,ind) - a_Dyx_1 * tirages_G_1(1,ind);
    b_Dyx_2 = tirages_G_2(2,ind) - a_Dyx_2 * tirages_G_2(1,ind);

end