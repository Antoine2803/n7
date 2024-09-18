% function correlation_contraste (pour exercice_1.m)

function [correlation,contraste] = correlation_contraste(X)
    n = size(X,2);
    X_chapeau = X - mean(X);
    sigma = (1/n)*(X_chapeau'*X_chapeau);
    correlation = zeros(n);
    for i = 1:n
        for j = 1:n
            correlation(i,j) = sigma(i,j)/sqrt(sigma(i,i)*sigma(j,j));
        end
    end
    contraste = zeros(1,n);
    for i = 1:n
        contraste(1,i) = sigma(i,i)/trace(sigma);
    end
end
