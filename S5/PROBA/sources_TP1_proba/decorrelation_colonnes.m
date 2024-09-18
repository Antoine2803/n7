% Fonction decorrelation_colonnes (exercice_2.m) 

function I_decorrelee = decorrelation_colonnes(I)
       i_zero = zeros(size(I));
       i_zero(:,2:end) = I(:,1:end-1);
       I_decorrelee = I - i_zero;


end