% fonction calcul_bon_partitionnement (pour l'exercice 1)

function meilleur_pourcentage_partitionnement = calcul_bon_partitionnement(Y_pred,Y)
    perm = perms(unique(Y_pred));
    Y_new = zeros(length(Y_pred),length(perm));
    for i = 1:length(perm)
        for j = 1:length(Y_pred)
            Y_new(j,i) = perm(i,Y_pred(j));
        end
    end
    meilleur_pourcentage_partitionnement = 100 * max(sum((Y == Y_new),1))/length(Y);
end