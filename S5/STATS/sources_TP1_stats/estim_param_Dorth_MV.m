% Fonction estim_param_Dorth_MV (exercice_3.m)

function [theta_Dorth,rho_Dorth] = ...
         estim_param_Dorth_MV(x_donnees_bruitees,y_donnees_bruitees,tirages_theta)
    theta = sum((x_donnees_bruitees*cos(tirages_theta) + y_donnees_bruitees*sin(tirages_theta)).^2);
    [~,ind] = min(theta);
    theta_Dorth = tirages_theta(ind);
    rho_Dorth = sqrt(mean(x_donnees_bruitees)^2 + mean(y_donnees_bruitees)^2);


end