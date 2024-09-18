% fonction classification_MV (pour l'exercice 2)

function Y_pred_MV = classification_MV(X,mu_1,Sigma_1,mu_2,Sigma_2)
    n=size(X,1);
    modele_V1 = [];
    modele_V2 = [];
    for i = 1:n
        modele_V1(i,:) = exp(-0.5*(X(i,:)-mu_1)*inv(Sigma_1)*(X(i,:)-mu_1)')*1/(2*pi*sqrt(det(Sigma_1)));
        modele_V2(i,:) = exp(-0.5*(X(i,:)-mu_2)*inv(Sigma_2)*(X(i,:)-mu_2)')*1/(2*pi*sqrt(det(Sigma_2)));
    end
    Y_pred_MV = (modele_V2>modele_V1)+1;

    
end
