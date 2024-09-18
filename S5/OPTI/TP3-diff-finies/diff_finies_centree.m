% Auteur : J. Gergaud
% décembre 2017
% -----------------------------
% 



function Jac= diff_finies_centree(fun, x, option)
%
% Cette fonction calcule les différences finies centrées sur un schéma
% Paramètres en entrées
% fun : fonction dont on cherche à calculer la matrice jacobienne
%       fonction de IR^n à valeurs dans IR^m
% x   : point où l'on veut calculer la matrice jacobienne
% option : précision du calcul de fun (ndigits)
%
% Paramètre en sortie
% Jac : Matrice jacobienne approximé par les différences finies
%        real(m,n)
% ------------------------------------
n = length(x);
m = length(fun(x));
Jac = zeros(m,n);
w = max(eps,10^(-option));
h = sqrt(w)*max(abs(x),1).*sgn(x);
for j=1:n
    e = zeros(n,1);
    e(j) = 1;
    Jac(:,j) = (fun(x + h(j)*e)-fun(x- h(j)*e))/(2*h(j));
end
end


function s = sgn(x)
% fonction signe qui renvoie 1 si x = 0
if x==0
  s = 1;
else 
  s = sign(x);
end
end





