% function ACP (pour exercice_2.m)

function [C,bornes_C,coefficients_RVG2gris] = ACP(X)
    n = size(X,2);
    X_chapeau = X - mean(X);
    sigma = (1/n)*(X_chapeau'*X_chapeau);
    [W,D] = eig(sigma);
    [~,ind] = sort(diag(D),1,"descend");
    W_2 = W(:,ind);
    C = X*W_2;
    bornes_C = [min(min(C)),max(max(C))];
    coefficients_RVG2gris = W(:,1)/norm(W(:,1));
end
