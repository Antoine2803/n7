% fonction estim_param_MC_paire (pour exercice_2.m)

function parametres = estim_param_MC_paire(d,x,y_inf,y_sup)
    p = length(x);
    A = zeros(p,2*d -1);
    for i = 1:d-1
        at = vecteur_bernstein(x,d,i);
        A(:,i) = at(1:p,1);
        A(:,d-1+i) = at(1:p,1);
    end
    A(:,2*d-1) = 2* vecteur_bernstein(x,d,d);
    B = y_inf - y_inf(1)*vecteur_bernstein(x,d,0) + y_sup- y_sup(1)*vecteur_bernstein(x,d,0); 
    parametres = A\B;
end







