% Fonction RANSAC_2droites (exercice_2.m)

function [rho_F_estime,theta_F_estime] = RANSAC_2droites(rho,theta,parametres)

    % Parametres de l'algorithme RANSAC :
    S_ecart = parametres(1); % seuil pour l'ecart
    S_prop = parametres(2); % seuil pour la proportion
    k_max = parametres(3); % nombre d'iterations
    n_donnees = length(rho);
    ecart_moyen_min = Inf;
    for i = 1:k_max
        indices = randperm(n_donnees, 2);
        [rho_f, theta_f] = estim_param_F(rho(indices),theta(indices));
        indices_conformes = (abs(rho - rho_f * cos(theta - theta_f)) <= S_ecart);
        p = sum(indices_conformes)/n_donnees;
        if p > S_prop 
            [rhon, thetan, ecart_moyen] = estim_param_F(rho(indices_conformes), theta(indices_conformes));
            if ecart_moyen < ecart_moyen_min 
                rho_F_estime = rhon;
                theta_F_estime = thetan;
                ecart_moyen_min = ecart_moyen;
            end
        end
    end
end