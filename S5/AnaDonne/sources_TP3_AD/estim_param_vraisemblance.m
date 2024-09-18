% fonction estim_param_vraisemblance (pour l'exercice 1)

function [mu,Sigma] = estim_param_vraisemblance(X)
    mu = mean(X);
    n = length(X);
    Sigma = (X-mu)'*(X-mu) /n;

end