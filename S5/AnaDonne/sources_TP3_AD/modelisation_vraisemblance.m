% fonction modelisation_vraisemblance (pour l'exercice 1)

function modele_V = modelisation_vraisemblance(X,mu,Sigma)
    n=size(X,1);
    modele_V = zeros(n,1);
    for i = 1:n
        modele_V(i,:) = exp(-0.5*(X(i,:)-mu)*inv(Sigma)*(X(i,:)-mu)')*1/(2*pi*sqrt(det(Sigma)));
    end
end