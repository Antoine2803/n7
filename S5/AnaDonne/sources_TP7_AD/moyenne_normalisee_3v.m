% fonction moyenne_normalisee_3v (pour l'exercice 1bis)

function x = moyenne_normalisee_3v(I)
    % Conversion en flottants :
    I = single(I);
    
    % Calcul des couleurs normalisees :
    somme_canaux = max(1,sum(I,3));
    r = I(:,:,1)./somme_canaux;
    v = I(:,:,2)./somme_canaux;
    
    % Calcul des couleurs moyennes :
    r_barre = mean(r(:));
    v_barre = mean(v(:));
    rp = (mean(r(1,:) + r(end,:)) + mean(r(:,1) + r(:,end)))/4;
    
    diff = (rp-rc);
    x = [r_barre v_barre diff];


end
