% fonction estim_param_MC (pour exercice_1.m)

function parametres = estim_param_MC(d,x,y)
    p = length(x);
    A = zeros(p,d);
    for i = 1:d
        at = vecteur_bernstein(x,d,i);
        A(:,i) = at(1:p,1);
    end
    B = y - y(1)*vecteur_bernstein(x,d,0);
    parametres = A\B;
end
