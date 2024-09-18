% Fonction calcul_G_et_R_moyen (exercice_3.m)

function [G, R_moyen, distances] = calcul_G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)
    xg = sum(x_donnees_bruitees)/length(x_donnees_bruitees);
    yg = sum(y_donnees_bruitees)/length(y_donnees_bruitees);
    G = [xg, yg];
    R_moyen = sum(sqrt((x_donnees_bruitees - xg).^2 + (y_donnees_bruitees - yg).^2))/length(x_donnees_bruitees);


end