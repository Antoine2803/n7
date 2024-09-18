% function noircir_pixels_blancs (pour exercice_3.m)

function I_sans_blanc = noircir_pixels_blancs(I)
    I_sans_blanc = I;
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            if I(i,j) >= 255*ones(1,3)
                I_sans_blanc(i,j,:) = [0 0 0];
            end
        end
    end

    
end
