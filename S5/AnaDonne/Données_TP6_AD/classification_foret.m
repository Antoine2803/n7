% fonction classification_foret (pour l'exercice 2)

function Y_pred = classification_foret(foret, X)
    M_pred = zeros(length(X),length(foret));
    for i = 1:length(foret)
        M_pred(:,i) = predict(foret{i},X);
    end
    Y_pred = mode(M_pred,2);
    
end
