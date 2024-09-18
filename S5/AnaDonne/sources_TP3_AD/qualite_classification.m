% fonction qualite_classification (pour l'exercice 2)

function [pourcentage_bonnes_classifications_total,pourcentage_bonnes_classifications_fibrome, ...
          pourcentage_bonnes_classifications_melanome] = qualite_classification(Y_pred,Y)
    pourcentage_bonnes_classifications_total = sum(Y_pred == Y)/length(Y)*100;
    pourcentage_bonnes_classifications_fibrome = sum((Y_pred==1) .* (Y==1))/sum(Y==1)*100;
    pourcentage_bonnes_classifications_melanome = sum((Y_pred==2) .* (Y==2))/sum(Y==2)*100;


end
