% Fonction vectorisation_par_colonne (exercice_1.m)

function [Vg,Vd] = vectorisation_par_colonne(I)
    I_g = I(1:end, 1:end-1);
    I_d = I(1:end, 2:end);
    Vg = I_g(:);
    Vd = I_d(:);
end